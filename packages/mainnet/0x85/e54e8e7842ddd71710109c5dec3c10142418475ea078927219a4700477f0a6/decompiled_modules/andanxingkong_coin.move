module 0x85e54e8e7842ddd71710109c5dec3c10142418475ea078927219a4700477f0a6::andanxingkong_coin {
    struct ANDANXINGKONG_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANDANXINGKONG_COIN>, arg1: 0x2::coin::Coin<ANDANXINGKONG_COIN>) {
        0x2::coin::burn<ANDANXINGKONG_COIN>(arg0, arg1);
    }

    fun init(arg0: ANDANXINGKONG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDANXINGKONG_COIN>(arg0, 9, b"ANDANXINGKONG", b"ANDANXINGKONG_COIN", b"andanxingkong Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/149133275")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANDANXINGKONG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDANXINGKONG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANDANXINGKONG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANDANXINGKONG_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

