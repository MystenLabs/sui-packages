module 0xe5040e72406800aba6c92c5681e9ab3ec6ac57e7edd6816a7472ea4cb46d58b9::ming_xx_coin {
    struct MING_XX_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MING_XX_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MING_XX_COIN>(arg0, 8, b"MY_COIN", b"MING_XX", b"this is MYCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img1.baidu.com/it/u=22878553,612949489&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1067")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MING_XX_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MING_XX_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MING_XX_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MING_XX_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

