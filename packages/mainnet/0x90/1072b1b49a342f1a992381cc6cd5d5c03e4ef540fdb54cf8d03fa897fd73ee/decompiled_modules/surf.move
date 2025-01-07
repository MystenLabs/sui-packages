module 0x901072b1b49a342f1a992381cc6cd5d5c03e4ef540fdb54cf8d03fa897fd73ee::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURF>(arg0, 9, b"SURF", b"SURFSUI", x"24535552462069732061206d656d65636f696e206c61756e63686564206f6e207468652040576176654f6e53756920706c6174666f726d20616e64206275696c74206f6e2074686520405375694e6574776f726b20626c6f636b636861696e2e2047657420726561647920746f20726964652074686520776176657320f09f8c8a2077697468206f757220666561726c65737320737572666572204b6f72677920f09f90b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0604d784-202e-4fef-8ed7-8d349f97afbe-IMG_2899.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

