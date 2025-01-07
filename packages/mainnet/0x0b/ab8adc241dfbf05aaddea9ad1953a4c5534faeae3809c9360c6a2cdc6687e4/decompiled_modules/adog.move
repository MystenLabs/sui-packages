module 0xbab8adc241dfbf05aaddea9ad1953a4c5534faeae3809c9360c6a2cdc6687e4::adog {
    struct ADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADOG>(arg0, 9, b"ADOG", b"AstroDoge", b"AstroDoge is a decentralized meme coin that aims to take the crypto world by storm. Inspired by the legendary Dogecoin and fueled by the power of the  SUI blockchain, AstroDoge is here to bring fun, community, and potentially, astronomical returns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5af3a221-68a1-4b0d-95d8-ba91df5329fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

