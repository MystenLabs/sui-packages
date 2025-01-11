module 0x94fae50acbb74e785ecf638521681cc4379cac767a4198ce2af50282771e8844::boai {
    struct BOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOAI>(arg0, 6, b"BOAI", b"BOAI by SuiAI", b"AI-powered game where players teach and shape the intelligence. Innovation, strategy, and collaboration all in one place.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DQ_Mai_m_N_400x400_149c9c9842.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

