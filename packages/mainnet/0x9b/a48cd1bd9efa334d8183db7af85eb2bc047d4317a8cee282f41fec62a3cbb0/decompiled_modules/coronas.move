module 0x9ba48cd1bd9efa334d8183db7af85eb2bc047d4317a8cee282f41fec62a3cbb0::coronas {
    struct CORONAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORONAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORONAS>(arg0, 9, b"CORONAS", b"WAWE", b"Sui inspires to go further, develop, catch the waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24ef40ca-045f-4a10-a765-67ea62f077e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORONAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORONAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

