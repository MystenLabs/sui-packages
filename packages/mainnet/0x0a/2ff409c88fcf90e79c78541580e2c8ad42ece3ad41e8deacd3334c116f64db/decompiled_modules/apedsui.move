module 0xa2ff409c88fcf90e79c78541580e2c8ad42ece3ad41e8deacd3334c116f64db::apedsui {
    struct APEDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEDSUI>(arg0, 6, b"ApedSui", b"Aped", b"Aped On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9211_f81b9f62dd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

