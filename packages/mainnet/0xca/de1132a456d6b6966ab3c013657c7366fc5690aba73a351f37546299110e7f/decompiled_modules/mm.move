module 0xcade1132a456d6b6966ab3c013657c7366fc5690aba73a351f37546299110e7f::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 6, b"MM", b"MASKED MEME", b"welcome and keep your masks on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733403844310.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

