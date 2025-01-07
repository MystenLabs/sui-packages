module 0xf84f21818cb12ae3b8fdca734030bec9fadf474639c8753499726b8ac6764a8::og {
    struct OG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OG>(arg0, 9, b"OG", b"OG", b"OG", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OG>>(v1);
    }

    // decompiled from Move bytecode v6
}

