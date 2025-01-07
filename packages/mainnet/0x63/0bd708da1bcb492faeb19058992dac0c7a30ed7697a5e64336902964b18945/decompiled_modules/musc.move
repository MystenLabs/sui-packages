module 0x630bd708da1bcb492faeb19058992dac0c7a30ed7697a5e64336902964b18945::musc {
    struct MUSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSC>(arg0, 6, b"MUSC", b"Mudera USuiCha", b"Official Madara Uchicha meme on SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731427496154.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

