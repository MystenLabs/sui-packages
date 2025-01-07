module 0x1d6920d9d3a6b4078c1be3c35f9488198c882136e9518568281d76e1e12afc28::fhj {
    struct FHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHJ>(arg0, 9, b"FHJ", b"JHD", b"How to get a good at it for ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f57fdf3-8b77-4098-bf30-00dd6237c762.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FHJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

