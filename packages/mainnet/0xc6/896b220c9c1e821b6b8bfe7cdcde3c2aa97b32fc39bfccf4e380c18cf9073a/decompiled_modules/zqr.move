module 0xc6896b220c9c1e821b6b8bfe7cdcde3c2aa97b32fc39bfccf4e380c18cf9073a::zqr {
    struct ZQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZQR>(arg0, 9, b"ZQR", b"Zhaqor", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27a07ded-2315-4f05-8e47-679f147bb6c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

