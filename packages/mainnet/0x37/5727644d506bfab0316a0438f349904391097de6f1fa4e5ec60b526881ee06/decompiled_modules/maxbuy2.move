module 0x375727644d506bfab0316a0438f349904391097de6f1fa4e5ec60b526881ee06::maxbuy2 {
    struct MAXBUY2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXBUY2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXBUY2>(arg0, 9, b"MB2", b"maxbuy2", b"mb2 again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/4d7b9aff-b509-4d20-b8c1-b8fb37c1f82b.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAXBUY2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXBUY2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

