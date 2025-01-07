module 0xc4b8a927737c7d73582f73f6266d9f187de0f328a90db09b5dbc724fa2e8a787::dildo {
    struct DILDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILDO>(arg0, 6, b"DILDO", b"Dildo BagHands Sui", b"Join $DILDO  BagHands on his animated adventure to defeat lord SauRUG and his army of JEETS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_new_pfp_brighter_192x192_8a3e5bd152.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

