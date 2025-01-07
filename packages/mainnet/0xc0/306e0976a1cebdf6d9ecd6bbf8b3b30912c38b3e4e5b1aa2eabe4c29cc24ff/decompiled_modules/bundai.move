module 0xc0306e0976a1cebdf6d9ecd6bbf8b3b30912c38b3e4e5b1aa2eabe4c29cc24ff::bundai {
    struct BUNDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNDAI>(arg0, 6, b"BUNDAI", b"Bundle AI", b"Bundle AI designed to promote transparency and fairness on tokens by analyzing \"bundled launches,\" where developers or insiders acquire disproportionate shares.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blj_KB_7q6_400x400_8d0dc74279.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNDAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

