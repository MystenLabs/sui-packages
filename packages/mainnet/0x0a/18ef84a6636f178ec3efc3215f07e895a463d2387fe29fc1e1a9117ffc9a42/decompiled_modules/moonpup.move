module 0xa18ef84a6636f178ec3efc3215f07e895a463d2387fe29fc1e1a9117ffc9a42::moonpup {
    struct MOONPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONPUP>(arg0, 9, b"MOONPUP", b"MoonPup", x"4d6f6f6e50757020697320746865206d656d6520636f696e2064657369676e656420746f2074616b6520796f75722063727970746f20647265616d7320746f206e65772068656967687473212057697468206120636861726d696e67207075707079206d6173636f7420616e6420612076696272616e7420636f6d6d756e6974792c206974e280997320616c6c2061626f75742066756e20616e6420726577617264732e204a6f696e20746865207061636b20616e64206c6574e280997320726561636820666f722074686520737461727320746f676574686572e280946f6e652070617720617420612074696d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d525b2e0-2485-4e93-9536-f2fcde43a342.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

