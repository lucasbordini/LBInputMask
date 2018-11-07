# LBInputMask

A simple way to format input according to provided mask


## HOW TO INSTALL

Just copy the file LBMaskTextField.swift to your project

## HOW TO USE

Symbols: 
 0 - Just number
 a - Just letters
 A - Just letters, and all uppercased
 # - Any alphanumeric

  ### - Using STORYBOARD
      * Add a textField on your storyboard
         ![alt text](https://image.ibb.co/nw3e5A/Screen-Shot-2018-11-07-at-14-28-33.png)

      * Select the textField, click on Identity Inspector and change class to LBMaskedTextField
         ![](https://image.ibb.co/cEFFdV/Screen-Shot-2018-11-07-at-14-30-14.png)

      * Click on Attributes Inspector and add your mask
         ![](https://image.ibb.co/b5KfCq/Screen-Shot-2018-11-07-at-14-49-54.png)

      * To get value just use getValue() on your textField
         ![](https://image.ibb.co/fa3RJV/Screen-Shot-2018-11-07-at-14-52-04.png)


  ### - Using CODE
      * Create a textField or reference for your textField
         ![](https://image.ibb.co/efu8yV/Screen-Shot-2018-11-07-at-14-36-59.png)

      * Create a variable to start your mask
         ![](https://image.ibb.co/dC8yXq/Screen-Shot-2018-11-07-at-14-54-24.png)

              ** You can add your mask later, if you need get their from API i.e.
               ![](https://image.ibb.co/gfMSsq/Screen-Shot-2018-11-07-at-14-40-18.png)

      * Add your mask as delegate for your textField
        ![](https://image.ibb.co/dpzadV/Screen-Shot-2018-11-07-at-14-41-13.png)

      * To get value just use getValue() on your DELEGATE
        ![](https://image.ibb.co/j2W5dV/Screen-Shot-2018-11-07-at-14-43-34.png)
  
