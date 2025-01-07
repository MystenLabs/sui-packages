module 0x91cf2f21d5dfaa411e5a74dcd87e642abbb254b577288e1fcfb3d8f8eb1ecefa::brettsui {
    struct BRETTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETTSUI>(arg0, 6, b"BRETTSUI", b"BRETT SUI", b"BRETT on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2023_12_21_22_39_17_27686149a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

