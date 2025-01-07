module 0xe8ca43673c65c2aaaf68a03f88fa977bd96c9b7aed82f5174ac58428d94a1fe9::waifus {
    struct WAIFUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFUS>(arg0, 6, b"WAIFUS", b"Sui Waifus", b"!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049675_2f6b297553.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIFUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

