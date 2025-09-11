module 0x53985a8a2c9e294c48eacb25d88c36c666353fab705df68e562f161634ccdbb3::Keyboard {
    struct KEYBOARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEYBOARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEYBOARD>(arg0, 9, b"KEY", b"Keyboard", b"keyboard is orange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0bKVi8XkAA8JYD?format=jpg&name=4096x4096")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEYBOARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEYBOARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

