module 0xd9e81c19a6d14d326d51285aa7c298b063df2c176c2463d3be4835f061a50348::withoutLPburn {
    struct WITHOUTLPBURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITHOUTLPBURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITHOUTLPBURN>(arg0, 9, b"WLB", b"withoutLPburn", b"without lp burning ser", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/91fed951-9da2-4c17-95c7-a73083505de7.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WITHOUTLPBURN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITHOUTLPBURN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

