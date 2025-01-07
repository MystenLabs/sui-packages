module 0xe176fdb9ec38609753e2f786a3ed93b9bbe51ca3cf07fadefdc9f45403bae7a5::ceuli {
    struct CEULI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEULI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEULI>(arg0, 9, b"CEULI", b"Ceuli", b"Ceuli oray", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/345d4cda-035a-4b40-ae58-5f137af19a8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEULI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CEULI>>(v1);
    }

    // decompiled from Move bytecode v6
}

