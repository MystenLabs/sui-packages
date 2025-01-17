module 0x1bfdf4c24ae1e0a6b24c62c726f3648908d977276ca0aa8ee2ff24492a43d542::bfish {
    struct BFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFISH>(arg0, 6, b"BFISH", b"BULLFISH", b"The Bullish Fish in the Sui waters, Join the community, build and win together ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a48f857e_4050_404d_b5d5_05ea2871c8a8_c0e535c9f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

