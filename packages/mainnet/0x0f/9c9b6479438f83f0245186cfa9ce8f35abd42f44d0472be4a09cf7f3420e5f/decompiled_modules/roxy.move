module 0xf9c9b6479438f83f0245186cfa9ce8f35abd42f44d0472be4a09cf7f3420e5f::roxy {
    struct ROXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROXY>(arg0, 9, b"ROXY", b"Roxy", b"https://twitter.com/RoxyOn_X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROXY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROXY>>(v2, @0xd64cc697bd83219c67fbe44563d769bbf82cac880037f26dad6caadeb7d49e73);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

