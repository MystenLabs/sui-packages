module 0x3a0df052b71d38a3fd418190c0113abd354d5ba7ae3f889e9497494307bb8159::dpuff {
    struct DPUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPUFF>(arg0, 6, b"DPUFF", b"Dragon Puff", b"A little Dragon who want to explore in the CRYPTO PLANET......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DRAGON_7d576b2531.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

