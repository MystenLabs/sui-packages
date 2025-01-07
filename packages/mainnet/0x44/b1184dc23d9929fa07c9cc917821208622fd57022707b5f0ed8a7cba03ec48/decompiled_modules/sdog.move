module 0x44b1184dc23d9929fa07c9cc917821208622fd57022707b5f0ed8a7cba03ec48::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 9, b"SDOG", b"SUIDOG", b"MEME of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30c01ca8-3803-47bf-bb40-df27ab95328c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

