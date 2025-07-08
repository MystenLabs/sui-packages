module 0xb1d6ada8014632ec02aa658c8ad17587c0d16df8a5544ea396512a18487e86fa::Bumble {
    struct BUMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMBLE>(arg0, 9, b"BUMBLE", b"Bumble", b"coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/4c6c210c-0c49-46ce-afd4-be065ba54e92.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUMBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMBLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

