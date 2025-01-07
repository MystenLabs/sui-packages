module 0xe33a71ae915a05af0acc87d5820bab583c8baa1f1255f6ccfbf1737fb1418884::am {
    struct AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AM>(arg0, 6, b"AM", b"Adeniyius maximus", x"4164656e6979697573206d6178696d757320746865206f7665726c6f7264206f66205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735993454143.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

