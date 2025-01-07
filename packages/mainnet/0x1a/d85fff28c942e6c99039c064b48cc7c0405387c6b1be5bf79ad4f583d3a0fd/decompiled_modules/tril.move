module 0x1ad85fff28c942e6c99039c064b48cc7c0405387c6b1be5bf79ad4f583d3a0fd::tril {
    struct TRIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIL>(arg0, 9, b"TRIL", b"tril", b"The best token ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/l7x9yQD")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRIL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

