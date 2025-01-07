module 0xd917a178889da62071a91698a5f1875aca859c152bac6d002524583b792d62b3::ogmc {
    struct OGMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGMC>(arg0, 6, b"OGMC", b"MEMECHAN", b"The original memechan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWvkyH4CwtXSTUStYfH2NLJGCDDVLsGx2RRJ768KzNKQn?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OGMC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGMC>>(v2, @0x6d8d6cbba2c993e8f290ca7121efea0f3f9bae8a4f7cd25554905a08ee3e53eb);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

