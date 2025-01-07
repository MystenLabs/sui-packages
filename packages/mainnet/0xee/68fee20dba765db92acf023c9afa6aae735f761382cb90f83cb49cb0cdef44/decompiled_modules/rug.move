module 0xee68fee20dba765db92acf023c9afa6aae735f761382cb90f83cb49cb0cdef44::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"Not rugging", x"5452555354204d452e20492057c4b04c4c204e4f542052554721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730997416314.2024")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

