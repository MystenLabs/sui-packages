module 0xa8ba4bcceee08b22204a37979b5218e6ab2f339137b9d815a1f103c8e630c8b::donkey {
    struct DONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DONKEY>(arg0, 6, b"DONKEY", b"donkey", b"donkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/esekaiaiai_3a5abf3919.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONKEY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

