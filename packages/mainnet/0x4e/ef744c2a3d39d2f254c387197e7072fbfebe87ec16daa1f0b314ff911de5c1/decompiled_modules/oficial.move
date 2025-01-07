module 0x4eef744c2a3d39d2f254c387197e7072fbfebe87ec16daa1f0b314ff911de5c1::oficial {
    struct OFICIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFICIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFICIAL>(arg0, 6, b"OFICIAL", b"SUIYAN CAT", b"Suiyan Cat is a playful, water-space flying creature with a Sui Pop-Tart torso, inspired by the iconic Nyan Cat. It zooms through a surreal blend of underwater and cosmic landscapes, leaving a vibrant, bullish rainbow trail behind it, symbolizing optimism and excitement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicat_afaa8c5671_50a505ee29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFICIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFICIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

