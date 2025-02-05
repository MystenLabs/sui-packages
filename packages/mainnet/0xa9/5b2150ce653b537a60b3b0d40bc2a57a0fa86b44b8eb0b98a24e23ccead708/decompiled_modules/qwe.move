module 0xa95b2150ce653b537a60b3b0d40bc2a57a0fa86b44b8eb0b98a24e23ccead708::qwe {
    struct QWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWE>(arg0, 9, b"QWE", b"QW", b"huhu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.thenounproject.com/png/447685-200.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

