module 0x9cc62c56614064f2a3ad2ed9371873251b861db6aa34949ce0cfc3ec8a12b3bf::sebat {
    struct SEBAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEBAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEBAT>(arg0, 9, b"SEBAT", b"Sebat SUI", b"SEBAT IN HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcb96241-f6e0-4b1f-bb75-9390bb658937.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEBAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEBAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

