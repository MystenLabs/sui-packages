module 0xd7ba8715c60348c76d8e3dc3b01dfb1e579aa108707cbc1bbe9aa81c2faf907c::herpes {
    struct HERPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERPES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HERPES>(arg0, 6, b"HERPES", b"HERPES AI", b"We are here for a long time, not a good time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1709_baecf23780.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HERPES>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERPES>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

