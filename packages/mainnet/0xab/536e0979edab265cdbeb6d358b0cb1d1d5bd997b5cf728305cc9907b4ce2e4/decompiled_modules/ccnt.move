module 0xab536e0979edab265cdbeb6d358b0cb1d1d5bd997b5cf728305cc9907b4ce2e4::ccnt {
    struct CCNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCNT>(arg0, 6, b"CCNT", b"Coconut Tree", b"You think you just fell out of a coconut tree? You exist in the context of all in which you live and what came before you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/iGWmS1n")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CCNT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCNT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

