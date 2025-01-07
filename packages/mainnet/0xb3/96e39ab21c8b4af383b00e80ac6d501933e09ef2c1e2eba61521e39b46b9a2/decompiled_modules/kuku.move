module 0xb396e39ab21c8b4af383b00e80ac6d501933e09ef2c1e2eba61521e39b46b9a2::kuku {
    struct KUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUKU>(arg0, 9, b"KUKU", b"Kuku", b"Buy at least one dollar and hold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10670b27-89a2-4ee6-8dfb-14f5bbd194f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

