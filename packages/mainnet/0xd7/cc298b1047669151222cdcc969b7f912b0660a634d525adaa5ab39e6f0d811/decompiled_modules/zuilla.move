module 0xd7cc298b1047669151222cdcc969b7f912b0660a634d525adaa5ab39e6f0d811::zuilla {
    struct ZUILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUILLA>(arg0, 6, b"ZUILLA", b"ZillaSui", b"Zilla on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7508_4810e15e8a.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

