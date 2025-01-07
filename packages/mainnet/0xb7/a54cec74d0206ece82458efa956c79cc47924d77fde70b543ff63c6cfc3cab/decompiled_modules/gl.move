module 0xb7a54cec74d0206ece82458efa956c79cc47924d77fde70b543ff63c6cfc3cab::gl {
    struct GL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GL>(arg0, 9, b"GL", b"Glglgl", b"Good luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a6d6d7a-8386-4b01-9652-207930f6eae7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GL>>(v1);
    }

    // decompiled from Move bytecode v6
}

