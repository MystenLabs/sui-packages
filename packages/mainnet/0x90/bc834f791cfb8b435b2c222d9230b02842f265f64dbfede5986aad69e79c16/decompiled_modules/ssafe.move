module 0x90bc834f791cfb8b435b2c222d9230b02842f265f64dbfede5986aad69e79c16::ssafe {
    struct SSAFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAFE>(arg0, 6, b"SSAFE", b"SAFESUI", b"Secure your wealth under the water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741196098026.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSAFE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAFE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

