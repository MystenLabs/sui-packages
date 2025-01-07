module 0x8d394ab524125720d837abba934f9b8d8a9cf70f4cb2856e63044459e50dedef::vs {
    struct VS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VS>(arg0, 9, b"VS", b"AEE", b"RTW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f21a927-47ea-49ac-8b6f-65f961315ea8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VS>>(v1);
    }

    // decompiled from Move bytecode v6
}

