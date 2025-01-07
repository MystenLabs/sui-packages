module 0xea39f2d882857fd27110adab77dfebc48d2e5264b5c63ff7a5f739a4a1717600::cx {
    struct CX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CX>(arg0, 9, b"CX", b"TGJHN", b"XB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4fe697cb-825e-4a3b-a960-f482507f43cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CX>>(v1);
    }

    // decompiled from Move bytecode v6
}

