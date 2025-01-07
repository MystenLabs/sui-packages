module 0xbbf8dce5bf00d6bea0e5a0767ac1370263293946ed2ead8849baf9f0ff4f1fe8::spt {
    struct SPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPT>(arg0, 9, b"SPT", b"Spaghetti", b"pure itallian, bon apetite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba4bff06-8b96-4424-9f2b-1f29fe59b3ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

