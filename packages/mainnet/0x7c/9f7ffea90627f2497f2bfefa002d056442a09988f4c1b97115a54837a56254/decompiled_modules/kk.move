module 0x7c9f7ffea90627f2497f2bfefa002d056442a09988f4c1b97115a54837a56254::kk {
    struct KK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KK>(arg0, 9, b"KK", b"Kiosk", b"8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcbab6d4-ce22-4258-b480-75872fabd17b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KK>>(v1);
    }

    // decompiled from Move bytecode v6
}

