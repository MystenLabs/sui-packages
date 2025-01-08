module 0xd627b40a7fee9212930896a9cdb1fec006437a8069d741348d4c07f802f22b4c::yt2 {
    struct YT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YT2>(arg0, 6, b"yt2", b"yt2", b"21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YT2>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YT2>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT2>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

