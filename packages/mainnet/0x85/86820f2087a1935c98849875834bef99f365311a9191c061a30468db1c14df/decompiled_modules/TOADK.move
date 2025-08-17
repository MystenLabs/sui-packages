module 0x8586820f2087a1935c98849875834bef99f365311a9191c061a30468db1c14df::TOADK {
    struct TOADK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOADK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOADK>(arg0, 6, b"Toad King", b"TOADK", b"Bow before the Toad King! A ribbiting meme coin for those who rule the swamp. Join the croakvolution and hop into the future of finance with this amphibious royalty. No lily pad left unturned!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafybeib7cokmmoecubfffbbrxxkejuaoosqlxrmrx2g6fyaa5m7vcgncr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOADK>>(v0, @0xbdebc33436425c9a7ca66a3b35925621c8885d16b3c741b9ca39527620462511);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOADK>>(v1);
    }

    // decompiled from Move bytecode v6
}

