module 0x6b4b5822b9eb30c98d494f6c73805ef6ea73b7ce48443b640481f46e09199279::suiwin {
    struct SUIWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIN>(arg0, 9, b"SUIWIN", b"SUIWIN", b"SUIWINNER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWIN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

