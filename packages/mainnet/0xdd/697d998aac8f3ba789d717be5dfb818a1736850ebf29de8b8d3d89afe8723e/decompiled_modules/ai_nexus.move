module 0xdd697d998aac8f3ba789d717be5dfb818a1736850ebf29de8b8d3d89afe8723e::ai_nexus {
    struct AI_NEXUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_NEXUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI_NEXUS>(arg0, 9, b"AI_NEXUS", b"A1X", b"The Al wrapper where Al agents get a digital body and a virtual playground. Powered by $A1X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebce47cd-3572-4f47-bce9-2cb22c82e698.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_NEXUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI_NEXUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

