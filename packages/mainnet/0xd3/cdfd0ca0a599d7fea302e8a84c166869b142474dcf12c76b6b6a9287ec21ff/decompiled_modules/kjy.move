module 0xd3cdfd0ca0a599d7fea302e8a84c166869b142474dcf12c76b6b6a9287ec21ff::kjy {
    struct KJY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJY>(arg0, 9, b"KJY", b"Kojaywow", b"Channel Cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/496dd258-2d19-493f-bb26-b77c08d4aee3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJY>>(v1);
    }

    // decompiled from Move bytecode v6
}

