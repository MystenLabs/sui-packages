module 0x1f1b4e035a6ba560811671fe99eb4f23a2b608b1e7bf42f35e7f5824fbfa4e76::b_cellfie {
    struct B_CELLFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CELLFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CELLFIE>(arg0, 9, b"bCELLFIE", b"bToken CELLFIE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CELLFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CELLFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

