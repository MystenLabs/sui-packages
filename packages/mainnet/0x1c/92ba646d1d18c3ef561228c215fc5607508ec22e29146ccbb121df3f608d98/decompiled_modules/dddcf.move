module 0x1c92ba646d1d18c3ef561228c215fc5607508ec22e29146ccbb121df3f608d98::dddcf {
    struct DDDCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDCF>(arg0, 9, b"DDDCF", b"Dinhdong", b"Bao xin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bb164dc-866c-4a58-b028-82990a92239b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDDCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

