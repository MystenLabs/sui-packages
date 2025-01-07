module 0x227110c6bdf86cd6914d9cfd9ab0d788dbdd0713b6d070176842e40fcda8e95a::degenchimp {
    struct DEGENCHIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGENCHIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGENCHIMP>(arg0, 9, b"DegenChimp", b"DEGEN CHIMP", b"DEGEN CHIMP MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGENCHIMP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGENCHIMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGENCHIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

