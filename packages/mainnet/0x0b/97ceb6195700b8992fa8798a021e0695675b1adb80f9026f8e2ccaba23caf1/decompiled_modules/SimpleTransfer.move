module 0xb97ceb6195700b8992fa8798a021e0695675b1adb80f9026f8e2ccaba23caf1::SimpleTransfer {
    public entry fun transfer_object<T0: store + key>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

