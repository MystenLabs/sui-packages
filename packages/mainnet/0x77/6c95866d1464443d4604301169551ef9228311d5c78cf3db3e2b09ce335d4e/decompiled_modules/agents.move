module 0x776c95866d1464443d4604301169551ef9228311d5c78cf3db3e2b09ce335d4e::agents {
    struct AGENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENTS>(arg0, 6, b"AgentS", b"Agent Start", x"206669727374204149206167656e74206f6e200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GU_Ts_Cop_Q_400x400_0dfcdd5ffd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

