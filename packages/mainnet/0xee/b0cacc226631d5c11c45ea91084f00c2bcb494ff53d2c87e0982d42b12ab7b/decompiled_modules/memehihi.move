module 0xeeb0cacc226631d5c11c45ea91084f00c2bcb494ff53d2c87e0982d42b12ab7b::memehihi {
    struct MEMEHIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEHIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEHIHI>(arg0, 9, b"MEMEHIHI", b"Hihimeme", b"Hihi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df4f5152-5360-48a9-9b76-4cbf95a57b4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEHIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEHIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

