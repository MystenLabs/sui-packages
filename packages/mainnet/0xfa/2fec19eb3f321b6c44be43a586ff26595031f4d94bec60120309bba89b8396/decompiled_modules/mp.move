module 0xfa2fec19eb3f321b6c44be43a586ff26595031f4d94bec60120309bba89b8396::mp {
    struct MP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MP>(arg0, 6, b"MP", b"MovePump", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Move_logo_cfb3437931.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MP>>(v1);
    }

    // decompiled from Move bytecode v6
}

