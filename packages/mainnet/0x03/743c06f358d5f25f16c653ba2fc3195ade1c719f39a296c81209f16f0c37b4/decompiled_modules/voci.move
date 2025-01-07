module 0x3743c06f358d5f25f16c653ba2fc3195ade1c719f39a296c81209f16f0c37b4::voci {
    struct VOCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOCI>(arg0, 6, b"VOCI", b"Voci AI", b"Voci Al is an Al-powered voice platform on the Sui blockchain, delivering seamless interaction and innovation through advanced technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734999837630.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

