module 0x919157d076d2545f2b7d7637360efdf46fcd5b3783f07bfa662480a25caf129e::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"HOPCAT SUI", x"48692c2049276d20486f702c2074686520636f6f6c65737420636174206f6e2073756921205965732c2049276d206c696b650a74686174202d2049206a756d70206c696b652061207265616c206174686c6574652c206f7220616c6d6f73742e2e2e204275740a6576657279206a756d702049206d616b6520697320612073686f772120416c736f2c206265747765656e20796f750a616e64206d652c2049206c6f766520746f2065617420666973682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopcat_6dbbcb583c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

