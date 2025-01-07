module 0xaa2488f98b8f639429f0e3b1d21c404fea9c031287fdb3e9dea32b66b15fa50b::catson {
    struct CATSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSON>(arg0, 6, b"CATSON", b"Sui Catson", x"48692049276d20434154534f4e2066726f6d20537569206e6574776f726b0a4d7920636f6d6d756e697479206f6620436174204c6f766572730a6e6f772074616b652063617265206f66206d6520616e64206d7920667269656e647321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010255_99136b78bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

