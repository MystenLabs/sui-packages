module 0x334832ecae4a7edc7eae1658f8043ad2220bed631f7bf576aa5a9c02207a1b9a::patton {
    struct PATTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATTON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PATTON>(arg0, 6, b"PATTON", b"Patton Trumps Dog by SuiAI", b"Patton is Trumps dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2060_b1d062804c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PATTON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATTON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

