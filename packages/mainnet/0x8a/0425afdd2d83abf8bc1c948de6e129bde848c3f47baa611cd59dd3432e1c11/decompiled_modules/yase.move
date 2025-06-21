module 0x8a0425afdd2d83abf8bc1c948de6e129bde848c3f47baa611cd59dd3432e1c11::yase {
    struct YASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YASE>(arg0, 6, b"YaSe", b"yase", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/8046b54c-5a7e-4437-a5c3-01202628be7a.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YASE>(&mut v2, 21000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YASE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

