module 0x45ddfd42a3066c1c0eb350cc563b079051fa00692a1c6b7971c4c878c0ad1d6f::suki {
    struct SUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKI>(arg0, 6, b"SUKI", b"SuiSuki", x"53554b4920546865206f6e6c7920646f6c7068696e6520726964696e67206f6e2053554920210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241017_121557_087_30ccd65309_e3733bffb2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

