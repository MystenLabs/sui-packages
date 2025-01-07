module 0xd6787053c66e6b302be18f28cf249564e6bd429998c01f56c5ce857efafa2bfe::hip {
    struct HIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIP>(arg0, 9, b"HIP", b"HipHip", b"Meme is meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f34935e-21bb-4bd3-a3b9-4f5eb141201d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

