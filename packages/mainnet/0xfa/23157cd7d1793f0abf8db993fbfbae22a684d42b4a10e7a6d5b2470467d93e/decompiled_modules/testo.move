module 0xfa23157cd7d1793f0abf8db993fbfbae22a684d42b4a10e7a6d5b2470467d93e::testo {
    struct TESTO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTO>>(0x2::coin::mint<TESTO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTO>(arg0, 6, b"TESTO", b"TESTO", b"TESTO MEME COIN", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

