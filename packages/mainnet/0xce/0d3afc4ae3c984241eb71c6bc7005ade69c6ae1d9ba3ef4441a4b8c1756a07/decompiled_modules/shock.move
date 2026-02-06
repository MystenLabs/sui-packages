module 0xce0d3afc4ae3c984241eb71c6bc7005ade69c6ae1d9ba3ef4441a4b8c1756a07::shock {
    struct SHOCK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHOCK>, arg1: 0x2::coin::Coin<SHOCK>) {
        0x2::coin::burn<SHOCK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHOCK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SHOCK>(arg0) + arg1 <= 1000000000000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHOCK>>(0x2::coin::mint<SHOCK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOCK>(arg0, 9, b"SHOCK", b"AfterShock Token", b"Governance token for AfterShock platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicy2yq7uextlhc52cnmg6gxkfwasl2xqnmndssr2k7xl6e6epr37a")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOCK>>(v0, @0x9d95ad3601de917ab5a4f0ef169148ec19f5aba5de7f04c9a3822baf53e050aa);
    }

    // decompiled from Move bytecode v6
}

