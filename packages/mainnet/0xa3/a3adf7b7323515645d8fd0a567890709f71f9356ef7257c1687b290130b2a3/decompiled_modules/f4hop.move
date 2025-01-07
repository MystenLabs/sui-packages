module 0xa3a3adf7b7323515645d8fd0a567890709f71f9356ef7257c1687b290130b2a3::f4hop {
    struct F4HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: F4HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F4HOP>(arg0, 6, b"F4HOP", b"F4ckhop", x"4634434b20594f5520424f4e4b4d414e0a4634434b20594f552052554745582046495253542044494e4f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949453984.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F4HOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F4HOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

