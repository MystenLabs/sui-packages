module 0x3af0e3f1dfce740a550144bc0a09446274e028fa83ae77a81423cd1ec0736937::raynor_coin {
    struct RAYNOR_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAYNOR_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RAYNOR_COIN>>(0x2::coin::mint<RAYNOR_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RAYNOR_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAYNOR_COIN>(arg0, 6, b"RC", b"raynor coin", b"mycoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAYNOR_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAYNOR_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

