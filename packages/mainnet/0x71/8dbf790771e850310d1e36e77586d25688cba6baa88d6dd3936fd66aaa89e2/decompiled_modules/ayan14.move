module 0x718dbf790771e850310d1e36e77586d25688cba6baa88d6dd3936fd66aaa89e2::ayan14 {
    struct AYAN14 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYAN14, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYAN14>(arg0, 9, b"AYAN14", b"Ayan", b"Future travels coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/708e7d6e-6907-49d2-a28e-2dc5e8e74c66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYAN14>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYAN14>>(v1);
    }

    // decompiled from Move bytecode v6
}

