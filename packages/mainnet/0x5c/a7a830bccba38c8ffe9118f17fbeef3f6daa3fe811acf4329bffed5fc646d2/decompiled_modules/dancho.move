module 0x5ca7a830bccba38c8ffe9118f17fbeef3f6daa3fe811acf4329bffed5fc646d2::dancho {
    struct DANCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANCHO>(arg0, 6, b"Dancho", b"Dancing Chowchow", b"Chowchow dog know how to dance when hears his fav DJ MUSIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/47vu8j_86083af6f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

