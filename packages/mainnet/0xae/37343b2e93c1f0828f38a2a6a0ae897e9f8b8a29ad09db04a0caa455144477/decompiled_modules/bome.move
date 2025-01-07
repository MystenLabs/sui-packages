module 0xae37343b2e93c1f0828f38a2a6a0ae897e9f8b8a29ad09db04a0caa455144477::bome {
    struct BOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 9, b"BOME", b"BomeCz", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8684d825-0706-4abf-b17b-706327a1562e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

