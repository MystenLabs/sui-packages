module 0x52f4170816c503b536b89645936eb7eeb2120293c16e9bc246d10451f07ba9ed::doginme {
    struct DOGINME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGINME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGINME>(arg0, 9, b"DOGINME", b"Doggy", b"Specialist of old dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fdc9257-9fcb-4863-8f76-36e2dd6ff764.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGINME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGINME>>(v1);
    }

    // decompiled from Move bytecode v6
}

