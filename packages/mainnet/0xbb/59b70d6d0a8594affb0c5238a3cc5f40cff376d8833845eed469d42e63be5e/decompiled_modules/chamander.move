module 0xbb59b70d6d0a8594affb0c5238a3cc5f40cff376d8833845eed469d42e63be5e::chamander {
    struct CHAMANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMANDER>(arg0, 6, b"Chamander", b"Char Sui", b"Welcome to the next generation of memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/021ae815e1908d1414b8efdba839452e_831cc4a29d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAMANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

