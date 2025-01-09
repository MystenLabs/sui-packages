module 0x86eeb986118ff5198d2d5821f06c9671ab820294eb68068bbfbbd2921eaaab3b::telemonaiagent {
    struct TELEMONAIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELEMONAIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELEMONAIAGENT>(arg0, 6, b"TelemonAIAgent", b"Telemon AI Agent", b"Telemon AI Agent ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N85_Kio_Bq_400x400_31a23282cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELEMONAIAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TELEMONAIAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

