module 0x9873746767f69bf5f7bba6f4e13fedb8e032c95b4229bf4d4a40cdd0421e451::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 9, b"BBS", b"Baby Shark", b"Baby Shark Suinetwotk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

