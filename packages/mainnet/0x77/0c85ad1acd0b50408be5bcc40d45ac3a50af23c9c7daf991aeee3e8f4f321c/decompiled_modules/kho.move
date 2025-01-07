module 0x770c85ad1acd0b50408be5bcc40d45ac3a50af23c9c7daf991aeee3e8f4f321c::kho {
    struct KHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHO>(arg0, 9, b"KHO", b"KHOKHO", b"BUY TERRIBLE GIRL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34882a55-903f-4455-a8e3-7538f9b954c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

