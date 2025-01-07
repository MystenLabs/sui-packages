module 0xcd436869cab9e578a9fa0337ff5c1877aec42e605aeaa79daf6575e2d617122f::amoy {
    struct AMOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMOY>(arg0, 6, b"AMOY", b"SuiAmoy", b"AMOY is a tiny, curious creature who loves to hop around and explore new places. Always up for an adventure, AMOY enjoys hanging out in the wild, leaping from one fun spot to another.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001104_cba2c6d59a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

