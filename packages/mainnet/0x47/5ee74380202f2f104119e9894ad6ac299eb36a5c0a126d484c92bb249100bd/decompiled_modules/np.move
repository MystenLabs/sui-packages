module 0x475ee74380202f2f104119e9894ad6ac299eb36a5c0a126d484c92bb249100bd::np {
    struct NP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NP>(arg0, 6, b"NP", b"No Pokemon", b"No telegram, no X, no website, no pokemon, just joke pokemon, buy this shit and hold, thank me later", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_94e75a2b99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NP>>(v1);
    }

    // decompiled from Move bytecode v6
}

