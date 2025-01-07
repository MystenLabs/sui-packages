module 0x2176c594c4416dd1cb90893656db889a9a14c80744363f42adaf93afe84d9160::ahasd {
    struct AHASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHASD>(arg0, 9, b"AHASD", b"HAHAHS", b"ASDASDASDDAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a82fa50a-288e-43ae-8b8e-5649a2ab0de9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

