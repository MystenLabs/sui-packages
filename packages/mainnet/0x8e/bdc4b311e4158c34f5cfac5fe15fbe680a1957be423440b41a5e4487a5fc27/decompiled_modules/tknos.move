module 0x8ebdc4b311e4158c34f5cfac5fe15fbe680a1957be423440b41a5e4487a5fc27::tknos {
    struct TKNOS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TKNOS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TKNOS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TKNOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<TKNOS>(arg0, 9, b"TKNOS", b"Demo Dollar", b"A configurable regulated token issued on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/26375/large/sui_asset.jpeg")), true, arg1);
        let v4 = v1;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKNOS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TKNOS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TKNOS>>(0x2::coin::mint<TKNOS>(&mut v4, 10000000000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKNOS>>(v4, v0);
    }

    // decompiled from Move bytecode v7
}

