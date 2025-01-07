module 0xc528d9c2008fc789360c53bd6b8b608d19341a9a57ae8020fcc160ad1e405c20::chrome {
    struct CHROME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHROME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHROME>(arg0, 9, b"CHROME", b"Chrome", b"CHROMEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f09f3ae-d112-4fd9-9f20-9093d1828d47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHROME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHROME>>(v1);
    }

    // decompiled from Move bytecode v6
}

