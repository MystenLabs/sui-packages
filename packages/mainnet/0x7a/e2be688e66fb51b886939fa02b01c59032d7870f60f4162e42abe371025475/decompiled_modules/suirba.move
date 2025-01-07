module 0x7ae2be688e66fb51b886939fa02b01c59032d7870f60f4162e42abe371025475::suirba {
    struct SUIRBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRBA>(arg0, 9, b"SUIRBA", b"Suirba", x"2453554952424120697320746865206d656d6520726562656c206f6620537569e280946e6f2072756c65732c206a757374206c617567687320616e64206d6f6f6e20766962657321204a6f696e20746865202453554952424120747269626520616e64206c6574e28099732070756d70207570207468652066756e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bronze-solid-dragonfly-121.mypinata.cloud/ipfs/QmaLeB3vfaPvFYfzi15C6xy3hfmi3KHLGtJeR17JTYUjj3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRBA>(&mut v2, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

