module 0x436fa6fc63244984d465e70137d586f314f1f6a2f7fa171b98f6b3066b09ec5f::sm {
    struct SM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SM>(arg0, 9, b"SM", b"spider man", b"2 spider men.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/77e740e4dcd58f20f2e10c0ff9805ee5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

