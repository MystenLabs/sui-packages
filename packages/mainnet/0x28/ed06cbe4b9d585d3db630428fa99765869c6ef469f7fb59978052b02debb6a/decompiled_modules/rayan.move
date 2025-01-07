module 0x28ed06cbe4b9d585d3db630428fa99765869c6ef469f7fb59978052b02debb6a::rayan {
    struct RAYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAYAN>(arg0, 9, b"RAYAN", b"RAYAN", b"RAYAN Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAYAN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAYAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

