module 0xdd0acc4949986141615b494146727dc92bb7c751776e76d9c34de4feb0abc27d::nexus {
    struct NEXUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEXUS>(arg0, 6, b"NEXUS", b"NexusOS by SuiAI", b"NexusOS is a technology company developing solutions to revolutionize the field of artificial intelligence. It offers AI-based chatbots, language processing models and customized AI solutions. Now, NexusOS is taking innovation one step further and stepping into the world of blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2185_62d67c0580.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEXUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

