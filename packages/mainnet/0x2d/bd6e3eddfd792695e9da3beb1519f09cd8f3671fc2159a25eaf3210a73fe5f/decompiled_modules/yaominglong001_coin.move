module 0x2dbd6e3eddfd792695e9da3beb1519f09cd8f3671fc2159a25eaf3210a73fe5f::yaominglong001_coin {
    struct YAOMINGLONG001_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YAOMINGLONG001_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YAOMINGLONG001_COIN>>(0x2::coin::mint<YAOMINGLONG001_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YAOMINGLONG001_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<YAOMINGLONG001_COIN>(arg0, 8, b"YAOMINGLONG001", b"YAOMINGLONG001 Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAOMINGLONG001_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<YAOMINGLONG001_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAOMINGLONG001_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

