module 0x4b7cc509d7ac887e1b8092861ca0563f9032705968830832558b0dfffe6ff7d4::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 9, b"COCO", b"coinex", b"trading for u ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d2e8409-755e-4f2c-9641-b49e88933e88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

