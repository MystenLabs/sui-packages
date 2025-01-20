module 0xddcbc8aefb387c644cf93c07fb584651277567b88e0f398d7bc8bc5863f29778::fakebot {
    struct FAKEBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKEBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FAKEBOT>(arg0, 6, b"FAKEBOT", b"Fakebot by SuiAI", b"This is fakebot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000110960_cc354edd4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAKEBOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKEBOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

