module 0x774cb9ee0653049b02d2be8b36d166a1a72a07a1ad7c388de455fa56ebf09d95::suichita {
    struct SUICHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHITA>(arg0, 6, b"SUICHITA", b"Suichita", b"Pochita on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_17_419bb5a45e_17de7c644f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

