module 0xf929b3b0d54d56e81bef596eeef9d396cb7bc39bb02c340ceed48907c04332e6::trumpmagadoge {
    struct TRUMPMAGADOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMAGADOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMAGADOGE>(arg0, 9, b"TRUMPMAGADOGE", b"TRUMPMAGADOGE", b"make 1000x again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ichef.bbci.co.uk/news/1024/branded_news/11004/production/_105363696_donald_trump_maga.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPMAGADOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMAGADOGE>>(v2, @0xf77deb5327ad4d5c260ddc86b579c8c5ad50a28e619cc1cd4cb26197eb7060ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPMAGADOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

