module 0xdf20afe8ac1fcebc8bb0f841f5e828e4ce0a90b51bc908ed78d0f8ceb40a9402::molon {
    struct MOLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLON>(arg0, 6, b"Molon", b"elongi", b"elongi molongi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746272715878.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

