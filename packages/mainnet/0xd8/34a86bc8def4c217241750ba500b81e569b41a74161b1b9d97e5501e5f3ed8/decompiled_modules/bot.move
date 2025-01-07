module 0xd834a86bc8def4c217241750ba500b81e569b41a74161b1b9d97e5501e5f3ed8::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOT>(arg0, 9, b"BOT", b"Bot", b"Botter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b1d0438-7689-482d-8c27-2a1bb0545f27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

