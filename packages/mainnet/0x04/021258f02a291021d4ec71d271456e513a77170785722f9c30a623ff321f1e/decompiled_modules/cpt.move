module 0x4021258f02a291021d4ec71d271456e513a77170785722f9c30a623ff321f1e::cpt {
    struct CPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPT>(arg0, 6, b"CPT", b"Crypto Partisans Token", b"Old Bsc dev of AlphaADA and BetaADA. Looking to build a community around this token. slow organic mooner. Join us to build a better future on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_24_at_14_56_34_4384edabaa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

