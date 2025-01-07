module 0x404e2b544c1d289ac81f87e620e570f06876b23a8f3ca8c74d36cd11519970b0::BelenLuoCoin {
    struct BELENLUOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELENLUOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELENLUOCOIN>(arg0, 1, b"BL", b"Belen-Luo", b"This is the Coin that Belen created in order to learn move", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELENLUOCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELENLUOCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BELENLUOCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BELENLUOCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

