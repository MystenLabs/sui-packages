module 0xd0c2c3963383ef78d1a16724b21a8517256136feaa1dba29ce5f5e404f2e5d22::dogskas {
    struct DOGSKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAS>(arg0, 9, b"DOGSKAS", b"Wewe", b"Gi you my tu day not ting ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/196599cc-3b5d-4155-9c58-3f823e38efda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

