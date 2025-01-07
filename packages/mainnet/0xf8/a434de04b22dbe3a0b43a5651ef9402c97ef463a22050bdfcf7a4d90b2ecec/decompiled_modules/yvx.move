module 0xf8a434de04b22dbe3a0b43a5651ef9402c97ef463a22050bdfcf7a4d90b2ecec::yvx {
    struct YVX has drop {
        dummy_field: bool,
    }

    fun init(arg0: YVX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YVX>(arg0, 9, b"YVX", b"YUVOX", b"YUVOX is a revolutionary cryptocurrency dedicated to preserving our planet's forests and ecosystems. With every transaction, you contribute to global efforts in forest conservation, planting trees, and protecting endangered habitats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa8f7c65-e6e7-4214-8e10-65162277e08b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YVX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YVX>>(v1);
    }

    // decompiled from Move bytecode v6
}

