module 0x27f74f4014f66d737978f02668ad6b3166806d458afa2c9a7b7beb8506e1e7cb::engy {
    struct ENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENGY>(arg0, 9, b"ENGY", b"ENERGY ", b"Free energy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae8f8c7f-8bdd-44db-8d86-092fa6e82dc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

