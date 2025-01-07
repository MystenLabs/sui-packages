module 0x14434e69de6a61c36f64285c6ec78c707e000b731a433fdf070ef5b186f15fe9::suichain {
    struct SUICHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAIN>(arg0, 6, b"SUICHAIN", b"Sui Chain", x"4c696e6b696e672074686520537569204e6574776f726b20746f6765746865722c2024535549434841494e20697320746865206261636b626f6e65206f6620636f6e6e656374696f6e2e205374726f6e672c207365637572652c20616e6420756e627265616b61626c6520207468697320636861696e206b656570732065766572797468696e6720666c6f77696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_66_9dde5349ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

