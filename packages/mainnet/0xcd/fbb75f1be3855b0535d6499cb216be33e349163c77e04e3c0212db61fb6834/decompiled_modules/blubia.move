module 0xcdfbb75f1be3855b0535d6499cb216be33e349163c77e04e3c0212db61fb6834::blubia {
    struct BLUBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBIA>(arg0, 6, b"BLUBIA", b"Blubiadotsui", b"$BLUBIA is queen of the Sui Ocean! While $BLUB brings the chaotic and degenerate energy, $BLUBIA embodies a wild yet graceful presence, blending the playful humor of meme culture with an undeniable strength and elegance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036890_1a69ae3daa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

