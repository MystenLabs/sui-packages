module 0x52a62daed010bbb1164bfc78e0f8e3684aa61721cdab42b9ff114c4770c1ddd4::yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETI>(arg0, 6, b"YETI", b"Yeti", b"SUI's Yeti man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yetir_55c66a388e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETI>>(v1);
    }

    // decompiled from Move bytecode v6
}

