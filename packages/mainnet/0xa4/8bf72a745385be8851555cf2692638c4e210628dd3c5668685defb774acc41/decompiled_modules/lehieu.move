module 0xa48bf72a745385be8851555cf2692638c4e210628dd3c5668685defb774acc41::lehieu {
    struct LEHIEU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEHIEU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEHIEU>(arg0, 9, b"LEHIEU", b"Hieule", b"Nguoi noi tieng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5017cb69-21f8-4e7f-85e2-9235d298ff8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEHIEU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEHIEU>>(v1);
    }

    // decompiled from Move bytecode v6
}

