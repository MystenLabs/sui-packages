module 0x4e8512cb40dcf967f19010d2f9bfa2c3051468a0ab64edf0447c88e7af1cb83f::youlixiaosheng_faucet {
    struct YOULIXIAOSHENG_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YOULIXIAOSHENG_FAUCET>, arg1: 0x2::coin::Coin<YOULIXIAOSHENG_FAUCET>) {
        0x2::coin::burn<YOULIXIAOSHENG_FAUCET>(arg0, arg1);
    }

    fun init(arg0: YOULIXIAOSHENG_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOULIXIAOSHENG_FAUCET>(arg0, 9, b"YOULIXIAOSHENG_FAUCET", b"YOULIXIAOSHENG_FAUCET", b"youlixiaosheng's faucet coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/147264753?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOULIXIAOSHENG_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<YOULIXIAOSHENG_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOULIXIAOSHENG_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YOULIXIAOSHENG_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

