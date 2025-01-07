module 0x7c6c490f85f891576e04fbe073957e95a7caad7d152dc100b2a25488e589c5af::br {
    struct BR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BR>(arg0, 9, b"BR", b"Bear", x"526f617220696e746f2072696368657320776974682042656172436f696e3a20546865206669657263652063727970746f63757272656e6379207468617427732064656c69766572696e6720626561722d73697a65642070726f6669747320616e642077696c6420616476656e747572657320696e207468652063727970746f206a756e676c652120f09f90bbf09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0d387d0-0053-49ba-bb57-6a3bfca9b3e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BR>>(v1);
    }

    // decompiled from Move bytecode v6
}

