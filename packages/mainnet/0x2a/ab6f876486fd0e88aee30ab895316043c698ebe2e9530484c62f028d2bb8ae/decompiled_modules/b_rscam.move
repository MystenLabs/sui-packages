module 0x2aab6f876486fd0e88aee30ab895316043c698ebe2e9530484c62f028d2bb8ae::b_rscam {
    struct B_RSCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_RSCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_RSCAM>(arg0, 9, b"bRSCAM", b"bToken RSCAM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_RSCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_RSCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

