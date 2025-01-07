module 0x29f20d75e1e071d6d1920a347e1fb5f3f2079d70454bc66eb507b6669a4a7682::belon {
    struct BELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELON>(arg0, 6, b"bELON", b"BABY ELON", b"Baby Elon On SUIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rw_S5pq_DP_400x400_80a5ee85dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

