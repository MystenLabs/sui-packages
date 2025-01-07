module 0xae58c080ac4016f5f99b6b67629081b642c0b8e1b4beae1533b656d4d3bec45::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"FuriesFluffyOnSui", b"$Fluffy-matt furie's original character from his legendary comic series", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_031158_ae22b82559.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

