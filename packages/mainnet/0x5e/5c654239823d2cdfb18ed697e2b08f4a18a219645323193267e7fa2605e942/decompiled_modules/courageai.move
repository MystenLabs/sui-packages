module 0x5e5c654239823d2cdfb18ed697e2b08f4a18a219645323193267e7fa2605e942::courageai {
    struct COURAGEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COURAGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COURAGEAI>(arg0, 6, b"COURAGEAI", b"Agent Courage by SuiAI", b"The offbeat adventures of Courage, a cowardly dog who must overcome his own fears to heroically defend his unknowing farmer owners from all kinds of dangers, paranormal events and menaces that appear around their land.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dp_suia_ab3210c572.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COURAGEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COURAGEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

