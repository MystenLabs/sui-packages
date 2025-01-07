module 0x932655a60bf366c7d0b519adc9b9a15200bdbf846f691d2d09c147672caed59e::pesuy {
    struct PESUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESUY>(arg0, 6, b"PESUY", b"PEPE BUT SUI", b"The memecoin of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prettyboy_8bbb2da72def71feff2b_65851574af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

