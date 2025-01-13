module 0x31b0e5aa1dc4c62f745d8895a62d7850d958ed899475a71eaa570f012c1ced17::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANIME>(arg0, 6, b"ANIME", b"Animecoin by SuiAI", b"ANIME is the token powering the open anime universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8103_029fae1362.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANIME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

