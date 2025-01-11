module 0xa7ab77985244bbda9b25fd102143d62ea132783dd68c84ae574f5cb23b91f69d::artnova {
    struct ARTNOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTNOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ARTNOVA>(arg0, 6, b"ARTNOVA", b"ArtNova Agent by SuiAI", b"Art Nova is an artificial intelligence agent designed to support, accelerate and improve the creative process, art management and interaction between artists, galleries and collectors in both digital and traditional art ecosystems. The agent uses AI technology to understand art trends, analyze works and facilitate cross-disciplinary collaboration.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_126_27442d37d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARTNOVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTNOVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

