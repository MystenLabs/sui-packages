module 0xded803bef81a8ac413ec9ed73d94f97dadb7f078bc09eee13fcf72d9ca606ab2::fast {
    struct FAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAST>(arg0, 9, b"FAST", b"Fasters", b"The only way I could do that was ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2108f5dd-f794-4c7f-82c3-13c72a90766b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

