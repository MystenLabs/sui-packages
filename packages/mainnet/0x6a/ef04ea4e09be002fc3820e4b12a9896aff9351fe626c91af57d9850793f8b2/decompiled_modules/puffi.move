module 0x6aef04ea4e09be002fc3820e4b12a9896aff9351fe626c91af57d9850793f8b2::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"PUFFI", b"PUFFI ON SUI", b"Puffi meme on sui, king mascot pufff with hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/261_B2_EC_1_F53_F_462_D_BA_80_37_F17_AB_59_A32_a725c5f78f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

