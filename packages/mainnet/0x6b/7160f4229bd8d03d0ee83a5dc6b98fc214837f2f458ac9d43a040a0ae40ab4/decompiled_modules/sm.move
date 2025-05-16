module 0x6b7160f4229bd8d03d0ee83a5dc6b98fc214837f2f458ac9d43a040a0ae40ab4::sm {
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

