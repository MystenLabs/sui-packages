module 0xe8c43747159d8036568886ed39550f78d36f103958ffb10c2a6760ea88192ed6::plius {
    struct PLIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLIUS>(arg0, 9, b"PLIUS", b"Jajan", b"Plisni", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc0b1434-397a-491a-8ab5-be6a1bed4456.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

