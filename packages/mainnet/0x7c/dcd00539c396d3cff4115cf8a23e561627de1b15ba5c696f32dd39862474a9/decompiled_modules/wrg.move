module 0x7cdcd00539c396d3cff4115cf8a23e561627de1b15ba5c696f32dd39862474a9::wrg {
    struct WRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRG>(arg0, 6, b"wrg", b"ertgrb", b"erd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WRG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

