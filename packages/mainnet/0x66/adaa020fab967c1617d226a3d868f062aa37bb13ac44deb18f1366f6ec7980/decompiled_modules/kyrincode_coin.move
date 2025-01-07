module 0x66adaa020fab967c1617d226a3d868f062aa37bb13ac44deb18f1366f6ec7980::kyrincode_coin {
    struct KYRINCODE_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KYRINCODE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KYRINCODE_COIN>>(0x2::coin::mint<KYRINCODE_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KYRINCODE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYRINCODE_COIN>(arg0, 6, b"KYC", b"KyrinCode Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYRINCODE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYRINCODE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

