module 0x7d6e9b6edebc9892d401a381d328ae3bd65b6320985db985a97fc2acf00ac8f3::magicom {
    struct MAGICOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGICOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAGICOM>(arg0, 6, b"MAGICOM", b"Magicom by SuiAI", b"Start new cooking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000042074_f68d92cee4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGICOM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGICOM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

