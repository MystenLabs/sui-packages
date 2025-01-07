module 0x51ea7a5acecc2169a5d18db6021792919676303f1d4f6981275c7df28342180c::suny {
    struct SUNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNY>(arg0, 9, b"SUNY", b"Suniverse", b"Suniverse (SUNI) is a fun, community-driven token on the Sui blockchain, offering limitless opportunities in a decentralized digital universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1878060552/cleanutlogo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUNY>(&mut v2, 15000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

