module 0x32ae8b849f335b849474a42bc967f38cd0aca85c817bc2e5a78c1f6c6d32f87e::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPP>(arg0, 9, b"ppp", b"pp", b"p", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PPP>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

