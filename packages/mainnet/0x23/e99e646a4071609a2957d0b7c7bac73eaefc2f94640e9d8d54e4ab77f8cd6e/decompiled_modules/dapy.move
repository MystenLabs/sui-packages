module 0x23e99e646a4071609a2957d0b7c7bac73eaefc2f94640e9d8d54e4ab77f8cd6e::dapy {
    struct DAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAPY>(arg0, 9, b"DAPY", b"dapy", b"The degenerate capybara.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1fvsuv3rrz9o2.cloudfront.net/dogs/party_dressed.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAPY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAPY>>(v2, @0x941790201a6dbb52a7332434a5042f6964366c424735bebb23451caf327f6316);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

