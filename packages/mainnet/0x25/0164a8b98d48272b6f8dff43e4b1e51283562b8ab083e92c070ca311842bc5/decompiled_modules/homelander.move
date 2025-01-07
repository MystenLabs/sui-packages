module 0x250164a8b98d48272b6f8dff43e4b1e51283562b8ab083e92c070ca311842bc5::homelander {
    struct HOMELANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMELANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMELANDER>(arg0, 6, b"HOMELANDER", b"Homelander The Sup Man", x"24484f4d454c414e44455220737572676573207468726f7567682074686520736b696573206f662074686520537569204e6574776f726b2c20756e73746f707061626c6520616e6420756e726976616c65642e205769746820657665727920676c616e63652c20686520636f6d6d616e647320726573706563743b2077697468206576657279206d6f76652c206865206c6561766573206368616f7320696e206869732077616b652c20706f776572206265796f6e64206d656173757265206973206e6f7720796f75727320746f207769656c6461726520796f7520726561647920746f20646f6d696e6174652074686520626c6f636b636861696e3f0a0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluedown_61567779b3_b7e1a78098.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMELANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMELANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

