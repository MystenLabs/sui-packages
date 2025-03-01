module 0xa37ab245febb45c43746c5eec8d0157477066e15d901be1f1ddf9c3dd249ff68::jj {
    struct JJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJ>(arg0, 9, b"jj", b"jjcoin", b"test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JJ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

