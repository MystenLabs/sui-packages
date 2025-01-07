module 0xe11ae5f04133b9c22941b762dd4a10486e3baa75e84ce1391c1b90c481205fff::zzh156_coin {
    struct ZZH156_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZZH156_COIN>, arg1: 0x2::coin::Coin<ZZH156_COIN>) {
        0x2::coin::burn<ZZH156_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZZH156_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZZH156_COIN>>(0x2::coin::mint<ZZH156_COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: ZZH156_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZH156_COIN>(arg0, 7, b"zzh156_Coin", b"zzh156_Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZH156_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZH156_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

