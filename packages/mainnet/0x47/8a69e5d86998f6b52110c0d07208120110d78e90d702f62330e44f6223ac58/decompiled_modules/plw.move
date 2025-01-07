module 0x478a69e5d86998f6b52110c0d07208120110d78e90d702f62330e44f6223ac58::plw {
    struct PLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLW>(arg0, 9, b"PLW", b"Pillow", b"are you sleepy, buy this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d0122f0-fb5d-4e67-8184-b2795e882b70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

