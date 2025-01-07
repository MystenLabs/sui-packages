module 0xbde4059667ebed9514d6e55b1f7b973f2cc29eef6d9bf4ac89b1c7d11c220705::suideeng {
    struct SUIDEENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDEENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDEENG>(arg0, 6, b"SUIDEENG", b"MOODEENG ON SUI", b"MOODEENG ON SUI = SUIDEENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1658131979_24045_gif_url_3345bb474e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDEENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDEENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

