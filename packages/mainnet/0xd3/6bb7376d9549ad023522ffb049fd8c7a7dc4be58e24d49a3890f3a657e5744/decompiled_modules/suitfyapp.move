module 0xd36bb7376d9549ad023522ffb049fd8c7a7dc4be58e24d49a3890f3a657e5744::suitfyapp {
    struct SUITFYAPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITFYAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITFYAPP>(arg0, 6, b"SUITFYAPP", b"Suitfy", x"53756974667920736f6e6720616e64206d6f6e65792e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_3_a4ff595416.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITFYAPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITFYAPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

