module 0x434c2673706df767ccbba998e4f28db734b9c7f6d47c65d5f71e45da4d207266::chain {
    struct CHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAIN>(arg0, 6, b"CHAIN", b"Sui Chain", x"4c696e6b696e672074686520537569204e6574776f726b20746f6765746865722c2024434841494e20697320746865206261636b626f6e65206f6620636f6e6e656374696f6e2e205374726f6e672c207365637572652c20616e6420756e627265616b61626c65207468697320636861696e206b656570732065766572797468696e6720666c6f77696e672e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_96_1_2732663b37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

