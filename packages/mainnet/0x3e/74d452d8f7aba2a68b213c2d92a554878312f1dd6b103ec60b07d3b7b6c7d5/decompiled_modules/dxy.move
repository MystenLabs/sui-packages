module 0x3e74d452d8f7aba2a68b213c2d92a554878312f1dd6b103ec60b07d3b7b6c7d5::dxy {
    struct DXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXY>(arg0, 9, b"DXY", b"US Degen Index 6900", b"Going crazy on string jobs data", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x6900f7b42fb4abb615c938db6a26d73a9afbed69.png?size=lg&key=71f534")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DXY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

