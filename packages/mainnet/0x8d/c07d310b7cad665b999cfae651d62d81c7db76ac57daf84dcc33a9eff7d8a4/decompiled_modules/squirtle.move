module 0x8dc07d310b7cad665b999cfae651d62d81c7db76ac57daf84dcc33a9eff7d8a4::squirtle {
    struct SQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLE>(arg0, 9, b"SQUIRTLE", b"Squirtle", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/54Ek5bS.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIRTLE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRTLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

