module 0xb2bbb0b15815d48b1e34da6027e69b8b1d50ff205f468a299a312d42f0174176::hrk {
    struct HRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRK>(arg0, 9, b"HRK", b"Harika", b"Btcharikasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1778e183-eed4-4e79-82d5-93e86ccf480b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

