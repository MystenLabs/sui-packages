module 0x1ed8b9bf57c5a450fe3139b41f76961ff41520140f96c3d16e367a6f1bdbadeb::xscoin_faucet {
    struct XSCOIN_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSCOIN_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::option::none<0x2::url::Url>();
        let (v0, v1) = 0x2::coin::create_currency<XSCOIN_FAUCET>(arg0, 8, b"XSCOIN_FAUCET", b"XSCOIN_FAUCET", b"this is XSCOIN_FAUCET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/200202346?s=400&u=0bf2998d9aa3fbc7db0ef75b0ce17540049dddb1&v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSCOIN_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<XSCOIN_FAUCET>>(v0);
    }

    public fun myburn(arg0: &mut 0x2::coin::TreasuryCap<XSCOIN_FAUCET>, arg1: 0x2::coin::Coin<XSCOIN_FAUCET>) {
        0x2::coin::burn<XSCOIN_FAUCET>(arg0, arg1);
    }

    public entry fun mymint(arg0: &mut 0x2::coin::TreasuryCap<XSCOIN_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XSCOIN_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

