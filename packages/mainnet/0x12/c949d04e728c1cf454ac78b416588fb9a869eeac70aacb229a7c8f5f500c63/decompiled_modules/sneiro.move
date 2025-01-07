module 0x12c949d04e728c1cf454ac78b416588fb9a869eeac70aacb229a7c8f5f500c63::sneiro {
    struct SNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEIRO>(arg0, 9, b"SNEIRO", b"SuNeiro", b"SuNeiro a sequel of upcoming meme coming to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842121805617655808/fjeEGGJA.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNEIRO>(&mut v2, 1300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

