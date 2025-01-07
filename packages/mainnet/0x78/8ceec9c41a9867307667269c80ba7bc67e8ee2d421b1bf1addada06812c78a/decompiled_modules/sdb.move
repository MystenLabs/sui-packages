module 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb {
    struct SDB has drop {
        dummy_field: bool,
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: SDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDB>(arg0, 9, b"SDB", b"SuiDouBashi", b"SuiDouBashi's Utility Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihbfhpb2x5ysavna4oa7noodydda3f3y5w6krhgq4e5fwb46wlbya")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDB>>(0x2::coin::mint<SDB>(&mut v2, 1000000 * 0x2::math::pow(10, 9), arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

