module 0x59c4568ce0ffd4303ee6665d4b2d1da658f5157ae0b34c101c4fc046e8daa93d::teamsui {
    struct TEAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEAMSUI>(arg0, 6, b"TeamSui", b"Sui Vs Aptos", x"54686520756c74696d61746520636861696e2073686f77646f776e3a20537569205673204170746f732e20f09f92a5204d6574726963732c20636f6d6d756e6974792c206469616d6f6e642068616e6473e2809477686f20726569676e732073757072656d653f20436f6d6d756e6974792072657073206c65616420746865206368617267652e200a0a4d617920746865206265737420636861696e2077696e2120f09f8f86", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731344523235.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEAMSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEAMSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

