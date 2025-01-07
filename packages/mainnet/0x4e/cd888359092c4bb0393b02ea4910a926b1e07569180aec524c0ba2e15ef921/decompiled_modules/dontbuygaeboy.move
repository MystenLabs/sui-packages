module 0x4ecd888359092c4bb0393b02ea4910a926b1e07569180aec524c0ba2e15ef921::dontbuygaeboy {
    struct DONTBUYGAEBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUYGAEBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUYGAEBOY>(arg0, 6, b"Dontbuygaeboy", b"Test dont buy unless youre gae", b"Dont buy unless youre gae fr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060863_35d0771bb6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUYGAEBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTBUYGAEBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

