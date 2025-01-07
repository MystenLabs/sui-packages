module 0x77a8a0aeb117b742f767456d1b433f441e49f80fb1e574e842fe0f2b7b05c2ee::upo {
    struct UPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPO>(arg0, 6, b"UPO", b"UP", b"Just. Up only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20210202_atw_stonks_1000x700_aede2eca08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

