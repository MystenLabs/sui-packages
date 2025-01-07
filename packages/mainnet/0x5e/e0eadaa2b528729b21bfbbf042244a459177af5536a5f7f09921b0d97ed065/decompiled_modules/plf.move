module 0x5ee0eadaa2b528729b21bfbbf042244a459177af5536a5f7f09921b0d97ed065::plf {
    struct PLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLF>(arg0, 6, b"PLF", b"Pluflo", b"Pluflo is a meme token designed to capture the fun and viral energy of the crypto world, with strong potential for growth as it gains popularity and traction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002872_cbe75b30b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

