module 0x452ca38d56417a29e8643670a31849211ab97742d99b33ff4599260188e60326::chenmingnan_coin {
    struct CHENMINGNAN_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHENMINGNAN_COIN>, arg1: 0x2::coin::Coin<CHENMINGNAN_COIN>) {
        0x2::coin::burn<CHENMINGNAN_COIN>(arg0, arg1);
    }

    fun init(arg0: CHENMINGNAN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENMINGNAN_COIN>(arg0, 6, b"chenmingnan COIN", b"chenmingnan COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHENMINGNAN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHENMINGNAN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHENMINGNAN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHENMINGNAN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

