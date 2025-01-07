module 0x69525a0cc66423271b943ce0e4711f642b9148f3f8d9d027e412c502b2eec9cd::jsuiheals {
    struct JSUIHEALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSUIHEALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSUIHEALS>(arg0, 6, b"JSUIHEALS", b"Jizzus Sui Heals", b"Jizzus Sui Heals AMEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_61_b986ea4f48.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSUIHEALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JSUIHEALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

