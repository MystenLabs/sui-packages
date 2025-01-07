module 0xca0dd3b0fcad973d636ce88ad1909fbdde29e7e4bb4a91193096c48785a1777::american_samoa {
    struct AMERICAN_SAMOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMERICAN_SAMOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMERICAN_SAMOA>(arg0, 2, b"American Samoa", b"American Samoa", b"American Samoa will be FREE. American Samoa will WIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AMERICAN_SAMOA>(&mut v2, 333333333333333300, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMERICAN_SAMOA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMERICAN_SAMOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

