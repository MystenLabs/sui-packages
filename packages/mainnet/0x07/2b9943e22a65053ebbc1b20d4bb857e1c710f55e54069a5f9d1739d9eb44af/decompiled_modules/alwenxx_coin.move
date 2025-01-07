module 0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_coin {
    struct ALWENXX_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ALWENXX_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ALWENXX_COIN>>(0x2::coin::mint<ALWENXX_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ALWENXX_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<ALWENXX_COIN>(arg0, 8, b"ALWENXX", b"ALWENXX Coin", b"move coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALWENXX_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<ALWENXX_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALWENXX_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

