module 0x1403ba669c26ac36465086e5d7a2c398f794e70a6c0377087dfd80e6368621c6::suibad {
    struct SUIBAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAD>(arg0, 6, b"SUIBAD", b"SUI BADDIE", b"THE BADDEST B ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_08_at_10_42_38_PM_3186198f2e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

