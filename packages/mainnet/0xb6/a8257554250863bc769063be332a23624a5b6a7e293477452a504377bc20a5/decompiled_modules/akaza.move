module 0xb6a8257554250863bc769063be332a23624a5b6a7e293477452a504377bc20a5::akaza {
    struct AKAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKAZA>(arg0, 9, b"AKAZA", b"AKAZA COIN", b"SHIning on meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e399d66-5573-4c67-8831-8d04e1e4171b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKAZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

