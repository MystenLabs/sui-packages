module 0xa23d69fbb1b6bfba170d431d44e88a2bc302b3f7ba87b916537f9fc3f53d3c2f::sfcs {
    struct SFCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFCS>(arg0, 9, b"SFCS", b"CXB", b"SFGDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ddd3149-61d4-4472-b8f5-ee8679420847.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

