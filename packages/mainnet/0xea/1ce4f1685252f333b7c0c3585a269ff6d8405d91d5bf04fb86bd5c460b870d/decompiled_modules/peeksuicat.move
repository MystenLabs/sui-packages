module 0xea1ce4f1685252f333b7c0c3585a269ff6d8405d91d5bf04fb86bd5c460b870d::peeksuicat {
    struct PEEKSUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEKSUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEKSUICAT>(arg0, 6, b"PEEKSUICAT", b"PEEK SUI", b"Cat been lurking in the shadows, watching every move with sharp instincts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_15_235500295_0a7f364447.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEKSUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEKSUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

