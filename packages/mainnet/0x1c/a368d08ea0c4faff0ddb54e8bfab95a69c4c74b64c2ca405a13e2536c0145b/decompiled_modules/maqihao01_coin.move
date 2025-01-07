module 0x1ca368d08ea0c4faff0ddb54e8bfab95a69c4c74b64c2ca405a13e2536c0145b::maqihao01_coin {
    struct MAQIHAO01_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAQIHAO01_COIN>, arg1: 0x2::coin::Coin<MAQIHAO01_COIN>) {
        0x2::coin::burn<MAQIHAO01_COIN>(arg0, arg1);
    }

    fun init(arg0: MAQIHAO01_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAQIHAO01_COIN>(arg0, 9, b"MAQIHAO01_COIN", b"MAQIHAO01_COIN", b"coin create by mqh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167278891")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAQIHAO01_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAQIHAO01_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAQIHAO01_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MAQIHAO01_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

