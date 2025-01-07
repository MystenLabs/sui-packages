module 0x4041b3287d6f42f801b74b656738716428b39c3811e0f683fec1af147e4817cd::josie {
    struct JOSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSIE>(arg0, 6, b"JOSIE", b"Joise", b"Crocheted a beanie for my friends cat with tiny beans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054484_d5eeb66205.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

