module 0x7be4bc2d48086a832ef6d69fcd9ef7c5bb05941ad736ea0314907122a70e1c9b::bluewaffle {
    struct BLUEWAFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEWAFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEWAFFLE>(arg0, 6, b"Bluewaffle", b"blue waffle", b"gross", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950279192.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEWAFFLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEWAFFLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

