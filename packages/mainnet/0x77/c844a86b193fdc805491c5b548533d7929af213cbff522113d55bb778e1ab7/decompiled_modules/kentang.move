module 0x77c844a86b193fdc805491c5b548533d7929af213cbff522113d55bb778e1ab7::kentang {
    struct KENTANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENTANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENTANG>(arg0, 9, b"KENTANG", b"Kentang", b"nyam nyam nyam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/975fbc56-d90c-4e64-91c4-ac1173ddb496.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENTANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENTANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

