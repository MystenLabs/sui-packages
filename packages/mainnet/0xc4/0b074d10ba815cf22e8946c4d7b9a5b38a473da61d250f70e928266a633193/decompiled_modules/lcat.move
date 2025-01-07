module 0xc40b074d10ba815cf22e8946c4d7b9a5b38a473da61d250f70e928266a633193::lcat {
    struct LCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCAT>(arg0, 9, b"LCAT", b"LOVECAT", b"A CHAT SHOWING A LOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67b22c38-45ab-4f03-afdc-7a92fdbada57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

