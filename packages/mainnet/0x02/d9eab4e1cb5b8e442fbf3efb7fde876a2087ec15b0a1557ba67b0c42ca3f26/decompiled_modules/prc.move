module 0x2d9eab4e1cb5b8e442fbf3efb7fde876a2087ec15b0a1557ba67b0c42ca3f26::prc {
    struct PRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRC>(arg0, 9, b"PRC", b"porchers", b"vipvipip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48b288ea-5656-4d4f-b2da-7755427cb429.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

