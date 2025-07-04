module 0x7b8bf71fd53307750198cb43e8b61f75137684fae28dc3bb270ea83a6a869b69::Limbo {
    struct LIMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIMBO>(arg0, 9, b"LIMBO", b"Limbo", b"just a boy who is sad and lost. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3ec3ee43-2629-4d17-8d14-1012faf7fa7c.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

