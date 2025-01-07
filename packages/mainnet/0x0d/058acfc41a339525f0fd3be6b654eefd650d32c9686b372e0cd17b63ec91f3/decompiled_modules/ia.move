module 0xd058acfc41a339525f0fd3be6b654eefd650d32c9686b372e0cd17b63ec91f3::ia {
    struct IA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IA>(arg0, 9, b"IA", b"Inteligencia Artificial", b"New IA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b2567d1690796fddb720b3a476ab057dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

