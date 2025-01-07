module 0xd5710c429b10a3d3a73e50e6fbcb8cd3116b54dce7b3a52257a020097085c1ca::smaba {
    struct SMABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMABA>(arg0, 6, b"SMABA", b"SuiMABA", b"Make America Based Again on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0526_934b035fc3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

