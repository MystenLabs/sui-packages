module 0xcb12db32195041a807483c4a079523f269a9572ae4efa2cd769314ecc42a234b::freedom {
    struct FREEDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEDOM>(arg0, 9, b"FREEDOM", b"FREE", b"Freedom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c4dc21f-4030-4fc8-93e5-4c0739a33009.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEDOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREEDOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

