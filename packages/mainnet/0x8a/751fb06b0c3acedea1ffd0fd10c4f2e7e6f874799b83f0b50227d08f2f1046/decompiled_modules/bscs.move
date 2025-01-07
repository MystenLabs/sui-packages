module 0x8a751fb06b0c3acedea1ffd0fd10c4f2e7e6f874799b83f0b50227d08f2f1046::bscs {
    struct BSCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSCS>(arg0, 9, b"BSCS", b"BEST CATS", b"Best cats lover", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e04dc83-195f-4b57-83c6-ef07c45cefde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

