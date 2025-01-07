module 0xce69e9e9a5612fd3d7ad0073a2457734d82e937606a4a81082e2ed3152f645d4::nub {
    struct NUB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NUB>, arg1: 0x2::coin::Coin<NUB>) {
        0x2::coin::burn<NUB>(arg0, arg1);
    }

    fun init(arg0: NUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUB>(arg0, 4, b"NUB", b"NUB", b"SUI NUB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GtDZKAqvMZMnti46ZewMiXCa4oXF4bZxwQPoKzXPFxZn.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0x2dcf4cf33e8db8c553c5f1fb0fd68d81222927652d31cf604675e5322bb1407e, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUB>>(v2, @0x2dcf4cf33e8db8c553c5f1fb0fd68d81222927652d31cf604675e5322bb1407e);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NUB>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NUB>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

