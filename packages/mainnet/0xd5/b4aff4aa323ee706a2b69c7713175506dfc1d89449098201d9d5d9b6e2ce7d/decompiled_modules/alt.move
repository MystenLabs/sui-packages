module 0xd5b4aff4aa323ee706a2b69c7713175506dfc1d89449098201d9d5d9b6e2ce7d::alt {
    struct ALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALT>(arg0, 9, b"ALT", b"TRUM PUM", b"Trump pump is a meme coin created by the trump loving team is the trend 2025-2029", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b73c0a06-f089-46de-9975-56436e020072.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

