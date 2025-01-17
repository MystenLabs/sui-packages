module 0x72754ec1bbdcbdeee3beed6dd9275828f42716912bfd72110e0303d2708ada8::courageai {
    struct COURAGEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COURAGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COURAGEAI>(arg0, 6, b"COURAGEAI", b"Courage The Cowardly Dog by SuiAI", b"The offbeat adventures of Courage, a cowardly dog who must overcome his own fears to heroically defend his unknowing farmer owners from all kinds of dangers, paranormal events and menaces that appear around their land.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dp_suia_3fbd990675.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COURAGEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COURAGEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

