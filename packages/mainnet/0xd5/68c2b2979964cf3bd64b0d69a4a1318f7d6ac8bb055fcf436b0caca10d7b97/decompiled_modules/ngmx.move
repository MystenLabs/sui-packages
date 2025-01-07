module 0xd568c2b2979964cf3bd64b0d69a4a1318f7d6ac8bb055fcf436b0caca10d7b97::ngmx {
    struct NGMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGMX>(arg0, 6, b"NGMX", b"NIGGAMUS MAXIMUS ", b"NIGGAMUS MAXIMUS JOINED FORCES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735761904868.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGMX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGMX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

