module 0x51549b43b24f7143095763f8f2095e62a5455cf6c9d5e9290a02e907a8cf2f6::npsui2 {
    struct NPSUI2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPSUI2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPSUI2>(arg0, 6, b"NPSUI2", b"Non Playable Sui's chapter 2", b"NPC's have bridged from Sol to Sui to become $NPSUI's. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_001443_780_3faa737411.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPSUI2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPSUI2>>(v1);
    }

    // decompiled from Move bytecode v6
}

