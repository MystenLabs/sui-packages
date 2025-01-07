module 0x877f605d79e660e4442aa2b7a494ec99f1d4426a0b2202c41a2420910f16c9e6::cat_on_sui {
    struct CAT_ON_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT_ON_SUI>(arg0, 9, b"CAT_ON_SUI", b"CAT", b"Official Simons Cat On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee72c65c-ee40-4599-8c00-d5ece10878ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT_ON_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT_ON_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

