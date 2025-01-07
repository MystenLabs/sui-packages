module 0xe97bb23e7de83f43c4cba52c5b9cf6742de791c6e07c824716ca7cbdfffa91de::sdogs {
    struct SDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGS>(arg0, 9, b"SDOGS", b"SUI DOGS", b"SUI DOGS ON TELEGRAM FOR EVERYONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9d767f6-6228-4c3a-a2a1-b5d99670e3f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

