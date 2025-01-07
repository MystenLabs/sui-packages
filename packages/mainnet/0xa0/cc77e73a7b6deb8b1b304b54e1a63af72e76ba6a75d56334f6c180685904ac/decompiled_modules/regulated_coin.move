module 0xa0cc77e73a7b6deb8b1b304b54e1a63af72e76ba6a75d56334f6c180685904ac::regulated_coin {
    struct REGULATED_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<REGULATED_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGULATED_COIN>>(0x2::coin::mint<REGULATED_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGULATED_COIN>(arg0, 6, b"My Baby1", b"Baby", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://arweave.net/-0ZL6sYpkovz9_EE3VtIIMhajSOkzAWDo3DUJdtvOXI?ext=png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGULATED_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

