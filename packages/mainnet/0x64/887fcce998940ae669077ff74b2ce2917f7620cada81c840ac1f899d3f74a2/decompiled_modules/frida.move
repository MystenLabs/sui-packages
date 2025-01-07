module 0x64887fcce998940ae669077ff74b2ce2917f7620cada81c840ac1f899d3f74a2::frida {
    struct FRIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIDA>(arg0, 6, b"FRIDA", b"Frida The Merdog", b"My name  is Frida and I'm a Merdog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_dfa8437705.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

