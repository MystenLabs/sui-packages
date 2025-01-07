module 0x21297c705b2a56d5811e60d790fb0167146daa29372c08c5769f180f632770a5::mis {
    struct MIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIS>(arg0, 6, b"MIS", b"Make in Sui", x"4d616b6520696e205375690a4d616b6520627920547572426f730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973038617.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

