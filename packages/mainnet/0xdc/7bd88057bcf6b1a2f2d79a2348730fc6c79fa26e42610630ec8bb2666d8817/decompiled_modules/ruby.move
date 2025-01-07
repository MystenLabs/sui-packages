module 0xdc7bd88057bcf6b1a2f2d79a2348730fc6c79fa26e42610630ec8bb2666d8817::ruby {
    struct RUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBY>(arg0, 8, b"RUBY", b"Ruby Corp", b"Ruby Corp. aims to be at the forefront of AI development focused solely on the parts huge SP500 companies forget or are not as focused on. We specialize in security and privacy related AI services with possibilities to customize our products depending on the requests.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x2222d69eff9ad88755a65c6cdccad1871c4a7c9d.png?size=xl&key=af29b0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUBY>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

