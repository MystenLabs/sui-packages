module 0x591ec3bb63e76ab043fef777e5f4cd6a4ac951f5b55281655c96f588890af71a::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAMBO>, arg1: 0x2::coin::Coin<LAMBO>) {
        0x2::coin::burn<LAMBO>(arg0, arg1);
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 0, b"LAMBO", b"LAMBO", b"This is SUI LAMBO Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/ck86OLZ.jpeg")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin::mint_and_transfer<LAMBO>(&mut v3, 1000000000, @0x9d215edd9df966d48fc044e8915c5cfb8080bb529341a2cb34bb6dda2039cf40, arg1);
        0x2::coin::update_icon_url<LAMBO>(&v3, &mut v2, 0x1::ascii::string(b"https://i.imgur.com/ck86OLZ.jpeg"));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMBO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAMBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAMBO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

