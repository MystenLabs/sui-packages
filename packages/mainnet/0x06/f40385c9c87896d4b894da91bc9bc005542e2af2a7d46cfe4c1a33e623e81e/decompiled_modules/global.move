module 0x6f40385c9c87896d4b894da91bc9bc005542e2af2a7d46cfe4c1a33e623e81e::global {
    struct GLOBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOBAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOBAL>(arg0, 6, b"GLOBAL", b"Citizens of Earth", b"MUSK, MUSK, MUSK....... ELON WILL TURN THIS MEME INTO GOLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/earthciticens_ceb2733eba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOBAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

