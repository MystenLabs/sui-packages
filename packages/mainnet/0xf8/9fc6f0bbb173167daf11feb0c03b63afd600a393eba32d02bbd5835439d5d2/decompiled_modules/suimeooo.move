module 0xf89fc6f0bbb173167daf11feb0c03b63afd600a393eba32d02bbd5835439d5d2::suimeooo {
    struct SUIMEOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEOOO>(arg0, 9, b"SUIMEOOO", b"Suimeo cat", b"Rizz cat sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aca150ea-d218-4af8-a0b5-42cbace40a01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

