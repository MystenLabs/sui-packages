module 0x7ae16c3557ca55f140a7fd159b03e206edcae620abd35bee7125f3f1f8a87a4e::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"Crocodilo Bombardilo", b"Crocodilo Bombardilo hits SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieej4bagsw5qhwtqv2rrl6dhsxqmylaudd3r5ykrdwms44hsttvli")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROCO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

