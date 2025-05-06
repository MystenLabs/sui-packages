module 0x791bd60020a32dfb53ceaf1cbf5197a9337038014f30f3eb9faa7d80cde38360::ai_sui {
    struct AI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI_SUI>(arg0, 9, b"aiSUI", b"IntelAi Staked SUI", b"Gains magiques ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/0ab5b1c3-5f61-4818-af35-62de36f8bbbc/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

