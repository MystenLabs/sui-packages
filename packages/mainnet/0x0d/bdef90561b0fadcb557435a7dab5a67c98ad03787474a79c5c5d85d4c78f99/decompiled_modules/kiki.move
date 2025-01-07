module 0xdbdef90561b0fadcb557435a7dab5a67c98ad03787474a79c5c5d85d4c78f99::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 9, b"KIKI", b"KichiKichi", b"Kimochi token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e073f283-6ba1-483c-bd69-ef73265e52cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

