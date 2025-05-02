module 0x8d7890b82387a482586d573a1a0895a41b5edf5dac66e4ebe23a885e05f374c::anc {
    struct ANC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANC>(arg0, 6, b"ANC", b"Agent Cassette", b"Agent Casssette The analog soul never gets oldit rises when the world gets too loud. He is an elite operative of the secret organization known as The Tape Syndicate, a guardian of truths recorded on magnetic tape. No identity, no digital traceonly a code name whispered through the dark corridors of the underworld-Agent Cassette", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chat_GPT_Image_May_2_2025_10_14_28_PM_886a224709.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANC>>(v1);
    }

    // decompiled from Move bytecode v6
}

