module 0x86e724d1fbca3a48cd813605211328e6d7d794624527ee51e3b29b163b52627f::zor {
    struct ZOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOR>(arg0, 9, b"ZOR", b"ZORO RONA", b"Onepice for my life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d98149b-a56e-4b81-b209-3f454ebcbe3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

