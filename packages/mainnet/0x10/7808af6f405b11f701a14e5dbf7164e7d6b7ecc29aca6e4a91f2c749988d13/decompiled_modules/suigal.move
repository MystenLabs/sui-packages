module 0x107808af6f405b11f701a14e5dbf7164e7d6b7ecc29aca6e4a91f2c749988d13::suigal {
    struct SUIGAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAL>(arg0, 6, b"SUIGAL", b"SUIGA", b"SUIGA IS SUI GAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6528a17f99196467fd829bb2c59eb974_2647498570_738625c844.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

