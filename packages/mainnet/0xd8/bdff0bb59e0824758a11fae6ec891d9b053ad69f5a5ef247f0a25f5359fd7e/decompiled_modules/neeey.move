module 0xd8bdff0bb59e0824758a11fae6ec891d9b053ad69f5a5ef247f0a25f5359fd7e::neeey {
    struct NEEEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEEEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEEEY>(arg0, 9, b"NEEEY", b"Pi", b"Ghygfff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b757af7a-a16f-455b-94b1-66a1231ee8c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEEEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEEEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

