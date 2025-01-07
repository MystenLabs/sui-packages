module 0xa8be2b25a17e2e8559d9cf31dc20f6939b5888f2358870bbec3a8bf365f88f7b::scuba {
    struct SCUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBA>(arg0, 6, b"SCUBA", b"SCUBA Dog Sui", b"The cutest scuba diving pooch has landed on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zcb24_PCH_400x400_b2cd956359.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

