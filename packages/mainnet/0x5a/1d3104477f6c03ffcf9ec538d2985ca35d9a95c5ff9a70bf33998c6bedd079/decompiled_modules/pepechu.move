module 0x5a1d3104477f6c03ffcf9ec538d2985ca35d9a95c5ff9a70bf33998c6bedd079::pepechu {
    struct PEPECHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECHU>(arg0, 6, b"PEPECHU", b"PEPU", b"Unlike the other Pikachu, that buzzes with energy and excitement, Pepechu spends his days pondering the meaning of life, often staring into the distance with his wide, sad eyes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731693633568.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPECHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

