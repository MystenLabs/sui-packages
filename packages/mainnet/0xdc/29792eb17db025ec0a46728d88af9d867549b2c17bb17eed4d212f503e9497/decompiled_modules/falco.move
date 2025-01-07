module 0xdc29792eb17db025ec0a46728d88af9d867549b2c17bb17eed4d212f503e9497::falco {
    struct FALCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALCO>(arg0, 6, b"FALCO", b"Falcoin", b"y'all wanna hear my some music", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FALCOIN_LOGO_a7c6d8ab9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FALCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

