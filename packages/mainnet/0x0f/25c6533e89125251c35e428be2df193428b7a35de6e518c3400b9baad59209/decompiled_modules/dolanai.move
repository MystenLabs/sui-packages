module 0xf25c6533e89125251c35e428be2df193428b7a35de6e518c3400b9baad59209::dolanai {
    struct DOLANAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLANAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLANAI>(arg0, 6, b"DolanAI", b"Dolan Duck AI", b"Dolan Duck AI wins all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dolan_AI_2060d998e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLANAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLANAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

