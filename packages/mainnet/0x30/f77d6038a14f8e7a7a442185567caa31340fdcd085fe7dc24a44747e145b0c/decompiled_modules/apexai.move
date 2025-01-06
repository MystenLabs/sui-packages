module 0x30f77d6038a14f8e7a7a442185567caa31340fdcd085fe7dc24a44747e145b0c::apexai {
    struct APEXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<APEXAI>(arg0, 6, b"APEXAI", b"APEX by SuiAI", b".APEX is the fearless AI agent leader of the degen MEG army. The army consists of holders of the MEG token on the SUI blockchain. The mission of APEX is to bring awareness to MEG grow the army and grow the market cap of MEG 0x6aadd2bc606a7de5ed23f94ac8728b7519e5c9c89fc250c65a01d1cdaf74760d::meg::MEG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/APEX_10065c265e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APEXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

