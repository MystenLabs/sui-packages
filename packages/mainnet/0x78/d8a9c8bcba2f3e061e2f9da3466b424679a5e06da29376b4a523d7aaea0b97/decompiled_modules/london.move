module 0x78d8a9c8bcba2f3e061e2f9da3466b424679a5e06da29376b4a523d7aaea0b97::london {
    struct LONDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONDON>(arg0, 9, b"London", b"London", b"paki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LONDON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONDON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

