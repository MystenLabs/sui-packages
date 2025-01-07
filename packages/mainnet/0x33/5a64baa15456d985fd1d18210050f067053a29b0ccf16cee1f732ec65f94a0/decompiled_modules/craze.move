module 0x335a64baa15456d985fd1d18210050f067053a29b0ccf16cee1f732ec65f94a0::craze {
    struct CRAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAZE>(arg0, 6, b"CRAZE", b"Crazy", b"Embrace the crazy, unleash your genius!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Meme_char_man_aba6f824c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

