module 0xaee5d805bd5021956ae6d1a362c96c0ca0ce4feb0b8c6ca47a9bf8465294d3ac::hoangphuon {
    struct HOANGPHUON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOANGPHUON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOANGPHUON>(arg0, 9, b"HOANGPHUON", b"phuonggg", b"ddddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d922489-abdc-490c-a786-512c9ecbc01e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOANGPHUON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOANGPHUON>>(v1);
    }

    // decompiled from Move bytecode v6
}

