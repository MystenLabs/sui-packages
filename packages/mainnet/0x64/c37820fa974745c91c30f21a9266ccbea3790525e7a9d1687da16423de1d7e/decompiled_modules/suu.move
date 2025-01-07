module 0x64c37820fa974745c91c30f21a9266ccbea3790525e7a9d1687da16423de1d7e::suu {
    struct SUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUU>(arg0, 2, b"SUU", b"ovan suu", b"Co-founder of Suu Network Web 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/5fChOAv.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUU>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUU>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

