module 0xe1dce2a50025de6b3ca4a141471d6a5f04c2be1d05eb8ea9f64ede4c586cd75f::mum {
    struct MUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUM>(arg0, 9, b"MUM", b"MUMMY", b"Meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4de1efe3-4b9e-491e-bf22-42fae185b5ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

