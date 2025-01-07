module 0x5a62ece2a9d925b791bce0b0451b3b79ee85ad61911d44050d31715c994b46fb::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 6, b"SPONGE", b"Sponge on Sui", b"Meet $SPONGE. The funniest news anchor on Sui! Hes soaking up Sui vibes and dropping alpha with a side of laughs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_7c023f3348.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

