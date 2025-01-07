module 0x4170b0fe17d77f481ff938519a3e9f5f2553a614a3c6106c6f93343c58841937::facuetcoin {
    struct FACUETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun faucet(arg0: &mut 0x2::coin::TreasuryCap<FACUETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FACUETCOIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: FACUETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACUETCOIN>(arg0, 6, b"FACUET", b"FACUET COIN", b"FACUET COIN TEST", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACUETCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FACUETCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

