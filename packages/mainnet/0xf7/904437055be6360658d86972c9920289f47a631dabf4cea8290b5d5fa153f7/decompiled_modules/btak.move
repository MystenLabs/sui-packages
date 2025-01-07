module 0xf7904437055be6360658d86972c9920289f47a631dabf4cea8290b5d5fa153f7::btak {
    struct BTAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTAK>(arg0, 9, b"BTAK", b"Botaks", b"Botak gundul plontos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/914fbef3-1174-4d8a-ae71-1f33c994675a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

