module 0xf052e5ab9053c90de12687edc61445ded8b81acd215dd020ed9aca282dac884e::hammy {
    struct HAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMMY>(arg0, 6, b"HAMMY", b"Hammy the Hamster", x"486973206e616d652069732048616d6d7920287370656c6c656420616e792077617920686520646f65736e2774206361726529204865207573656420746f20626520612068616972206d6f64656c206275742068652077656e742062616c6420617420313720616e64206e6f7720686520697320726574697265642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hammylogo_ab20bb1c3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

