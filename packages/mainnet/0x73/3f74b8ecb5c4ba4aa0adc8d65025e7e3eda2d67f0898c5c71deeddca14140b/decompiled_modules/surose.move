module 0x733f74b8ecb5c4ba4aa0adc8d65025e7e3eda2d67f0898c5c71deeddca14140b::surose {
    struct SUROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUROSE>(arg0, 9, b"SUROSE", b"Summer Rose", b"A Rose in Summer 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fe2bd19d1aacab8b535f81c735450106blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUROSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUROSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

