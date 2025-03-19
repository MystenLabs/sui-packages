module 0x9c51ff5489a1d36b3ee876aa66ad927cc1910e61fbe9a81eab650f49800b47b8::mycoinFaucet {
    struct MYCOINFAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOINFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b""));
        let (v0, v1) = 0x2::coin::create_currency<MYCOINFAUCET>(arg0, 8, b"Banksy-w Faucet", b"Banksy-w Faucet", b"This is Banksy-w Faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOINFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MYCOINFAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

