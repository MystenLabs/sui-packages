module 0x265c82c678be9326770db43302253d63d4056846b9fd1ab10372e544f7d8ee15::zy_coin {
    struct ZY_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZY_COIN>>(0x2::coin::mint<ZY_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZY_COIN>(arg0, 9, b"ZY", b"ZY Coin", b"ZY Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/zy_coin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

