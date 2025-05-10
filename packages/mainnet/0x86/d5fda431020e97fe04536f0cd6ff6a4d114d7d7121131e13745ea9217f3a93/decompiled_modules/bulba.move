module 0x86d5fda431020e97fe04536f0cd6ff6a4d114d7d7121131e13745ea9217f3a93::bulba {
    struct BULBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULBA>(arg0, 6, b"BULBA", b"BulbaSUI", x"546865204f472076656767792066726f67206f6620537569210a2442554c424120626c656e64732042756c6261736175722076696265732077697468205375692d636861696e2073706963652e204e6f20646576732c206e6f20726f61646d6170206a757374206d656d65206d6167696320616e64207075726520636f6d6d756e69747920706f7765722e204361746368206974206265666f72652069742065766f6c76657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighexhib3yjqm3e2d3zmbns4xgjrinsjmo7gb5zv4fekd4fgf36dq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULBA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

