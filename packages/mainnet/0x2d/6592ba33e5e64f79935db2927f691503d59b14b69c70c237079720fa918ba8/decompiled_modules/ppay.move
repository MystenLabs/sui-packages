module 0x2d6592ba33e5e64f79935db2927f691503d59b14b69c70c237079720fa918ba8::ppay {
    struct PPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPAY>(arg0, 6, b"Ppay", b"Pear Pay", b"p2p payments", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://flng.b-cdn.net/Pearpay/pearpay.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PPAY>(&mut v2, 50000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPAY>>(v2, @0xbc51541f5fca97f47919b4aea866676e58200ad9a0b708885c0445210f861813);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

