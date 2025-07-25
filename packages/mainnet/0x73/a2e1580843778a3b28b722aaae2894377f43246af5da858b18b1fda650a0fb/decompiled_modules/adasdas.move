module 0x73a2e1580843778a3b28b722aaae2894377f43246af5da858b18b1fda650a0fb::adasdas {
    struct ADASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADASDAS>(arg0, 6, b"Adasdas", b"asdasd", b"adasas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifjct4gittuouzjrroo2gelh4upsqmyi6lk3qnhjec2by6mpjl6pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADASDAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

