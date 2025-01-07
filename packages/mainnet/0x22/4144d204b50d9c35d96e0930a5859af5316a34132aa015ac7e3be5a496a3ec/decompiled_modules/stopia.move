module 0x224144d204b50d9c35d96e0930a5859af5316a34132aa015ac7e3be5a496a3ec::stopia {
    struct STOPIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOPIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOPIA>(arg0, 6, b"STOPIA", b"SUITOPIA", b"Welcome to SUITOPIA! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241010_182903_bc6a6e3432.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOPIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOPIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

