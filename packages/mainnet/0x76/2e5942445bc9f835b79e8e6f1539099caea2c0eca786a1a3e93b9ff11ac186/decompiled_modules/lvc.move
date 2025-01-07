module 0x762e5942445bc9f835b79e8e6f1539099caea2c0eca786a1a3e93b9ff11ac186::lvc {
    struct LVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LVC>(arg0, 9, b"LVC", b"LV Coin", b"A toy coin as a gift to LV, what is otherwise like any other real cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.newyorker.com/photos/5995d33ae7e57c7bfef97a91/master/w_1920,c_limit/Petrusich_Total-Eclipse-of-The-Heart.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LVC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LVC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

