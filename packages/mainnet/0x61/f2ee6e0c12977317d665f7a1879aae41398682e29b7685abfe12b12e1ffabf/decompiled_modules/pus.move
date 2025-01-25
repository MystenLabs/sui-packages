module 0x61f2ee6e0c12977317d665f7a1879aae41398682e29b7685abfe12b12e1ffabf::pus {
    struct PUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PUS>(arg0, 6, b"PUS", b"PUSSY on SUI by SuiAI", b"Pussy on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cartoon_drawing_cute_little_kitten_with_red_nose_889056_171022_956f0b4567.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

