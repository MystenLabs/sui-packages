module 0x66b650519eb956d0bb5f0ac0b581545991e4067ee82be72c9cdda760d589aaa::taco {
    struct TACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TACO>(arg0, 9, b"TACO", b"TacoToken", b" Spicy returns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/127a91f4-d2b9-47f1-8f3c-7b6a29d67d91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

