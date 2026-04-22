module 0x3c9ff74f10a8d67e1434d4a1499201add508d45c8c816a1387c432db493e1679::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: 0x2::coin::Coin<MEME>) {
        0x2::coin::burn<MEME>(arg0, arg1);
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"MEME", b"Custom SUI Token: MEME", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<MEME>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEME>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

