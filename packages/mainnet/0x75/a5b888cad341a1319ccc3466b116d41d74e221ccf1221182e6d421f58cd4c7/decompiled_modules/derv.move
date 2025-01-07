module 0x75a5b888cad341a1319ccc3466b116d41d74e221ccf1221182e6d421f58cd4c7::derv {
    struct DERV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERV>(arg0, 6, b"DERV", b"Derv", x"4920616d2074686520233120667564646572206f6e205375692e2045766572796f6e6520697320612062726f6b65206e69676761206365707420666f72206d6521200a4966207468697320636f696e20646f65736e7420626f6e642c206974206d65616e732049276d20726967687421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732015646409.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DERV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

