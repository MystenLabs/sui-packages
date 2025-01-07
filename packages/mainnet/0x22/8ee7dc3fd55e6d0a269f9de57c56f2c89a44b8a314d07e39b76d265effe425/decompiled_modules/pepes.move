module 0x228ee7dc3fd55e6d0a269f9de57c56f2c89a44b8a314d07e39b76d265effe425::pepes {
    struct PEPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 6, b"PEPES", b"PepeCoins", b"MemeFi mania continues PepeCoins, Sui gold!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004403_93535558f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

