module 0x67e9b080d9caca5305613f7d2b9506e7381980e554903456b3fcbc5525c5703a::kev {
    struct KEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEV>(arg0, 6, b"KEV", b"Kevin on Sui", x"41626f757420244b45562c0a0a66726f6d204661696c75726520746f204f70706f7274756e6974792e0a4b6576696e277320526564656d7074696f6e206f6e205375693a2022526561647920746f2054616b65204f76657222", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Photo_26_9_24_11_49_26_PM_6e7a267cb8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

