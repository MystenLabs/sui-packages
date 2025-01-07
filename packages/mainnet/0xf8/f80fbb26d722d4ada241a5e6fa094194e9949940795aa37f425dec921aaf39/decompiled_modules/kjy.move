module 0xf8f80fbb26d722d4ada241a5e6fa094194e9949940795aa37f425dec921aaf39::kjy {
    struct KJY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJY>(arg0, 9, b"KJY", b"Kojaywow", b"Channel Cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/144ff77f-fd1a-4914-9e7f-d6b71bd6b8ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJY>>(v1);
    }

    // decompiled from Move bytecode v6
}

