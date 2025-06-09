module 0x295d5e5a7ce8b61f6e841bd7106751f7a5fe897e8d212d7bfac2a21b97acd61b::kjkj {
    struct KJKJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJKJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJKJ>(arg0, 9, b"jk", b"kjkj", b"kljlkj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/e261e2a7-02a0-439b-9bfe-a8beb395f044.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJKJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJKJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

