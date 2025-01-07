module 0x30cbd3addd9c432f8870d877b7a79b400500366b0e1d62ab2859260db3ee42d7::Monday {
    struct MONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONDAY>(arg0, 6, b"Monday", b"MONDAY", b"Monday is a meme token that is a tribute to the original Monday.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmcgGMfYi16PN5Sk8khMGQXoLB5J7YMLPPhtSvj4DxaHE4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

