module 0xb632426ae389dd6bb826b334442ee0be9fd919e68865357568d7355750e3b6b::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT>(arg0, 6, b"PEANUT", b"Peanut on SUI", b" Peanut SUI  Token | Join our journey to the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Q_Mcd4_UF_400x400_14da8b9043.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEANUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

