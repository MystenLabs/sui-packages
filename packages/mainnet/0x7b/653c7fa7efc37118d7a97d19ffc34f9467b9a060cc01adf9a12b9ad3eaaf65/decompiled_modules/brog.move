module 0x7b653c7fa7efc37118d7a97d19ffc34f9467b9a060cc01adf9a12b9ad3eaaf65::brog {
    struct BROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROG>(arg0, 9, b"BROG", b"brog", b"blue frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/60eab364-e503-4409-bf90-519cfd230937.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

