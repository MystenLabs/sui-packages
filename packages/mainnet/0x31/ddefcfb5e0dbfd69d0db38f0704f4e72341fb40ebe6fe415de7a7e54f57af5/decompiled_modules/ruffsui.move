module 0x31ddefcfb5e0dbfd69d0db38f0704f4e72341fb40ebe6fe415de7a7e54f57af5::ruffsui {
    struct RUFFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFFSUI>(arg0, 6, b"RUffSui", b"RUFF", b"Fuck Ruff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0274_37c6b0fd56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

