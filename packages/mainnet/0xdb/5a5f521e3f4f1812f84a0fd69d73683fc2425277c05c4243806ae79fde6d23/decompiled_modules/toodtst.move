module 0xdb5a5f521e3f4f1812f84a0fd69d73683fc2425277c05c4243806ae79fde6d23::toodtst {
    struct TOODTST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOODTST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOODTST>(arg0, 6, b"TOODtst", b"tood", b"asdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20221106_193845_2x_ddbe63c492.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOODTST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOODTST>>(v1);
    }

    // decompiled from Move bytecode v6
}

