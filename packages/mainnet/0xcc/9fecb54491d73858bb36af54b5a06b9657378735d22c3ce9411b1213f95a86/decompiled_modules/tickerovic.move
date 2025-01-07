module 0xcc9fecb54491d73858bb36af54b5a06b9657378735d22c3ce9411b1213f95a86::tickerovic {
    struct TICKEROVIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKEROVIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKEROVIC>(arg0, 9, b"TICKEROVIC", b"Testov", b"Descriptor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7883fb2b-db2c-414c-a77d-283f3dabb33b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKEROVIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKEROVIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

