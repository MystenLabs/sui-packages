module 0xf339b7088ec3622651c52b28cebff2815c7fb6589cf7ae359e4d57705d57b28b::jesse {
    struct JESSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESSE>(arg0, 6, b"JESSE", b"saashah", b"wqtqwtqwtwq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731011350969.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JESSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

