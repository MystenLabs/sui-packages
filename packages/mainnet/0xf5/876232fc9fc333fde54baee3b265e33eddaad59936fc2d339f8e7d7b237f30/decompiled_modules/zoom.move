module 0xf5876232fc9fc333fde54baee3b265e33eddaad59936fc2d339f8e7d7b237f30::zoom {
    struct ZOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOOM>(arg0, 9, b"ZOOM", b"ZoomerCoin", b"ZoomerCoin is a meme token designed specifically for the younger generation, especially the energetic and dynamic Gen Z. With a modern internet meme theme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24fbf984-b1e8-403b-8b29-d8c6467f4c14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

