module 0x8c89548be38255a0eb7ce5668d51be36d2776daecdb5b2bcee15b109302605::tswai {
    struct TSWAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSWAI>(arg0, 6, b"TSWAI", b"The Sui Wizard", b"AI-powered Wizard on Sui. Autonomous crypto brand to champion AI, analyse alpha, and collaborate with agents on Sui and across the blockchain. NFA, DYOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Tqc_W8_Ed_400x400_d2df887dff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSWAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSWAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

