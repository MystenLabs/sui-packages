module 0xdcabb38de872969f9425a811bcc1ef41ee6f056916226523a5f0c05dddf2932e::suixin {
    struct SUIXIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIXIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIXIN>(arg0, 6, b"SuiXin", b"Sui Fish", b"The chinese fish! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_42_3750503833.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIXIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIXIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

