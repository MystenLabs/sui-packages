module 0xf196c7f77ef9db4433edf05d0bc89492129cc9fbe101e925d4e2173f865bf97c::bandit {
    struct BANDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDIT>(arg0, 6, b"BANDIT", b"Bandit On Sui", b"Bandit on sui has one mission recruit and become the dominant meme project on SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002028_c3a6689e71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

