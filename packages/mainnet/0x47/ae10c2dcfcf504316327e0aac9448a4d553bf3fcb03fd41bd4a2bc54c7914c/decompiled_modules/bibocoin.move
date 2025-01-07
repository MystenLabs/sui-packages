module 0x47ae10c2dcfcf504316327e0aac9448a4d553bf3fcb03fd41bd4a2bc54c7914c::bibocoin {
    struct BIBOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBOCOIN>(arg0, 9, b"BIBOCOIN", b"BiBO", b"Very good coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24b5de72-8ee8-42de-ab1a-204e5fe408e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBOCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBOCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

