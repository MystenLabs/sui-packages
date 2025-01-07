module 0x8d44b40bf97cbc054252f0d35986237b57a61da697d601e1eb6a13bfb0484704::hasui {
    struct HASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUI>(arg0, 9, b"haSUI", b"haSUI", b"haSUI is a staking token of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HASUI>(&mut v2, 22383541000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUI>>(v2, @0x6ed4057c7cdc61bfcef5404f0c05d8725f1e80f46ae3c6b8ef7076ab91b7d3b3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

