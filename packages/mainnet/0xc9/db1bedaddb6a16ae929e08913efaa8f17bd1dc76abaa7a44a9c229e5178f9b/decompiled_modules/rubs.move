module 0xc9db1bedaddb6a16ae929e08913efaa8f17bd1dc76abaa7a44a9c229e5178f9b::rubs {
    struct RUBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBS>(arg0, 6, b"RUBS", b"Rubs", b"Im a Maltese dwog in a world ful of kats. Mi bigest insecuritii is I cant spelll, but fukit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_02_T205131_907_0c39473733.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

