module 0x234d94b8edc89816b626a4229d98860fcbc9005fac365faadab6e0845e6d0b04::coin_b {
    struct COIN_B has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_B>(arg0, 9, b"coin_b", b"CB", b"my coin b", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_B>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_B>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN_B>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COIN_B>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

