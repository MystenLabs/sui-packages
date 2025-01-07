module 0x1b5591d2d6c88f81c54d57fd6d37f02e1fec4e350ba34847569da57e356103e::suijeets {
    struct SUIJEETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJEETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJEETS>(arg0, 6, b"Suijeets", b"Suiper jeets", b"Official jeets on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000795_c8ab776e53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJEETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJEETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

