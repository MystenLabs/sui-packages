module 0xeef4b5aa3703edb0fe1b4435a3c3422c8f0bf19055f2363a6529bbdc71b009cd::suister_go {
    struct SUISTER_GO has drop {
        dummy_field: bool,
    }

    struct MaxSupply has store, key {
        id: 0x2::object::UID,
        max: u64,
        total_supply: u64,
    }

    struct SupplyInfo has key {
        id: 0x2::object::UID,
        circulating_supply: u64,
    }

    public fun get_circulating_supply(arg0: &SupplyInfo) : u64 {
        arg0.circulating_supply
    }

    public fun get_max_supply(arg0: &MaxSupply) : u64 {
        arg0.max
    }

    public fun get_total_supply(arg0: &MaxSupply) : u64 {
        arg0.total_supply
    }

    fun init(arg0: SUISTER_GO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISTER_GO>(arg0, 9, b"STG", b"Suister Go", b"A core driver of the Suister Go economy is $STG, the game's native utility token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaf6fg5wf4buhyn4b4mmhr5ymyyobbgwu7g2a2q25z2tapxpbjq7u")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISTER_GO>>(v2);
        let v4 = 10000000000000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISTER_GO>>(0x2::coin::mint<SUISTER_GO>(&mut v3, v4, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTER_GO>>(v3, v0);
        let v5 = MaxSupply{
            id           : 0x2::object::new(arg1),
            max          : v4,
            total_supply : v4,
        };
        0x2::transfer::share_object<MaxSupply>(v5);
        let v6 = SupplyInfo{
            id                 : 0x2::object::new(arg1),
            circulating_supply : v4,
        };
        0x2::transfer::share_object<SupplyInfo>(v6);
    }

    // decompiled from Move bytecode v6
}

