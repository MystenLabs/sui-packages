module 0xa3c92e5bd5afd4e578d3d722cc79d0b0881b68dd0dfd748fcc353e956f539dae::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 6, b"Gas", b"AAAdolf CAT", b"Supporting the SUI Blockchain Wif Low Gas Fee's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cats_that_look_like_hitler_feat_1_620x350_5874bfc7ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

