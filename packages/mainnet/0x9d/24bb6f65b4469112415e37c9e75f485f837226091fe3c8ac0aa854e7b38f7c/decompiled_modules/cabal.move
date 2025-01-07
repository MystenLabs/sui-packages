module 0x9d24bb6f65b4469112415e37c9e75f485f837226091fe3c8ac0aa854e7b38f7c::cabal {
    struct CABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABAL>(arg0, 6, b"CABAL", b"CABAL on SUI", b"Just CABAL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pi_Kr_Dn_W2_400x400_14b503066f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CABAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

