module 0xd8e394f5b43715a77cb0ab17d88b6439f0faf15da5c997aca359416bcb2cc2eb::prox {
    struct PROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROX>(arg0, 6, b"PROX", b"PROXIMO", b"Proximo 1000X BOME MQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uv_Pnzeyl_400x400_e5c0d2db8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROX>>(v1);
    }

    // decompiled from Move bytecode v6
}

