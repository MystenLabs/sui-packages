module 0xbc7b3b81d3d3f8932e5e7148074b29b55433fae8d969c86815534df5e5f9c133::zhaoxilingcheng_faucet {
    struct ZHAOXILINGCHENG_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZHAOXILINGCHENG_FAUCET>, arg1: 0x2::coin::Coin<ZHAOXILINGCHENG_FAUCET>) {
        0x2::coin::burn<ZHAOXILINGCHENG_FAUCET>(arg0, arg1);
    }

    fun init(arg0: ZHAOXILINGCHENG_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHAOXILINGCHENG_FAUCET>(arg0, 9, b"ZHAOXILINGCHENG_FAUCET", b"ZHAOXILINGCHENG_FAUCET", b"zhaoxilingcheng's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/30566370?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHAOXILINGCHENG_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZHAOXILINGCHENG_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZHAOXILINGCHENG_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZHAOXILINGCHENG_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

