module 0x334894de7330c9730fd51696a575117dadac3f6b6de32f20b15b816ba7a92635::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 6, b"T", b"Troll", b"troll is good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750391458447.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

