module 0x6d99558ff387c269abc9cd4000bd5d8fe69019819bf7ebe47eb3d479d90b4374::moonlite {
    struct MOONLITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONLITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONLITE>(arg0, 6, b"Moonlite", b"Moonlite ", x"5375692074726164696e67206174206974732066756c6c20706f74656e7469616c207c20486967682073706565647320e29ca6204c6f772066656573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967073134.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONLITE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONLITE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

