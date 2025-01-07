module 0x8883bc6ddc306c8ed2a650d9372837fbed5eb5b3b0e242b79a6f7dbd09763867::aon {
    struct AON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AON>(arg0, 9, b"AON", b"ANON SUI", b"$AON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/193e287e-e2fc-4102-915e-5fddd6a07be8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AON>>(v1);
    }

    // decompiled from Move bytecode v6
}

