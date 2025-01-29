module 0x3896f762942146ae1f3f662fe290956a2da930323725a5bc71e99e433dbdf08c::rtest {
    struct RTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTEST>(arg0, 9, b"RTEST", b"RTEST", b"by vulkan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RTEST>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

