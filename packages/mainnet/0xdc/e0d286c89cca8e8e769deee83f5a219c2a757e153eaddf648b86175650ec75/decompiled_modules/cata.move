module 0xdce0d286c89cca8e8e769deee83f5a219c2a757e153eaddf648b86175650ec75::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 6, b"CATA", b"Catamoto", x"43415441202d2041204465466920636f6d6d756e6974792d64726976656e206c61756e636870616420706f77657265642062792074686520244341544120746f6b656e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_LONU_13_Q_400x400_9ea0dc9a74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

