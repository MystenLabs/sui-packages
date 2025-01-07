module 0x5da7e6db2afdc2a74dc4c6ac20fd87b2a7b5eb231de065907349158138213e7c::kermit {
    struct KERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMIT>(arg0, 6, b"KERMIT", b"Kermit", x"546865204c6567656e646172792046726f67206f6e2053554920244b45524d4954207468652046726f672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029187_68f1e4b504.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

