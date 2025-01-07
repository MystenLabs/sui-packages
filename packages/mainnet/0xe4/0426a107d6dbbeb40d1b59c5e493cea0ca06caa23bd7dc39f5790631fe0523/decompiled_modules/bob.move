module 0xe40426a107d6dbbeb40d1b59c5e493cea0ca06caa23bd7dc39f5790631fe0523::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 9, b"BOB", b"Sponge Bob", b"Sponge Bob token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreig4adxjudmb6otzryje6tbv5fmlypznfkxounakqsb2rdrsjowobe.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

