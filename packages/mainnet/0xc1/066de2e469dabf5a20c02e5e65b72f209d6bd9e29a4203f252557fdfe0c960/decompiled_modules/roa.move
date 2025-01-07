module 0xc1066de2e469dabf5a20c02e5e65b72f209d6bd9e29a4203f252557fdfe0c960::roa {
    struct ROA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROA>(arg0, 9, b"ROA", b"COCKR", b" DID YOU SEE A BEAUTIFUL COCKROACH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83cf9bff-a467-4afc-aa7e-805010c8ade0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROA>>(v1);
    }

    // decompiled from Move bytecode v6
}

