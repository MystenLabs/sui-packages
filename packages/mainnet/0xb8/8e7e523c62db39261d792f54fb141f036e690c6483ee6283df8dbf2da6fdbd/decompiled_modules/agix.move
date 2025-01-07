module 0xb88e7e523c62db39261d792f54fb141f036e690c6483ee6283df8dbf2da6fdbd::agix {
    struct AGIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGIX>(arg0, 6, b"AGIX", b"AGIX project", x"204147495820697320616e20414920626c6f636b636861696e20736f6c7574696f6e20696e20746865205375692065636f73797374656d0a0a2d20436f7265206d697373696f6e3a20446576656c6f70696e672070726163746963616c20414920736f6c7574696f6e7320746861742067656e75696e656c792068656c70205375692075736572730a2d20566973696f6e3a2047726f77696e6720746f6765746865722077697468205375692065636f73797374656d207768696c652070726f766964696e67207265616c2d776f726c64204149206170706c69636174696f6e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735989372415.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

