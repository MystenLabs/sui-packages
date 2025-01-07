module 0x8b4bfde751cbd245bce351c1254b621ea7e5d81ea3ffe9747b93de9fc580c45c::nxbai {
    struct NXBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NXBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NXBAI>(arg0, 6, b"NXBAI", b"Nex Bot Advance AI", b"Nexui Bot Advance Token Scanner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736249944323.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NXBAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NXBAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

