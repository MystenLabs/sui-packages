module 0x8aec81ea0070b9071f23005230a95e4a657632fe90afd2417ebc2dbfbca8d52f::cuhien87 {
    struct CUHIEN87 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUHIEN87, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUHIEN87>(arg0, 9, b"CUHIEN87", b"Cuhien", b"Cu hien vo dich thien ha!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb2afd11-a27d-42b3-89ab-92a4810d233f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUHIEN87>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUHIEN87>>(v1);
    }

    // decompiled from Move bytecode v6
}

