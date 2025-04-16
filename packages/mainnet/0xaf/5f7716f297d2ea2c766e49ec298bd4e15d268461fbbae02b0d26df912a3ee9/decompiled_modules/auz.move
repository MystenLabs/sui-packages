module 0xaf5f7716f297d2ea2c766e49ec298bd4e15d268461fbbae02b0d26df912a3ee9::auz {
    struct AUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUZ>(arg0, 9, b"AUZ", b"Assuss", b"for the boiz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/283be1d8eeb87a5350ec2a2f5cb2f4a2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

