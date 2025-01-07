module 0x7cccd53ecebb08d299b1c60071022a8da59bc488d56684e39c2249609a33cd78::gong {
    struct GONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONG>(arg0, 9, b"gong", b"gong", b"gong1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GONG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

