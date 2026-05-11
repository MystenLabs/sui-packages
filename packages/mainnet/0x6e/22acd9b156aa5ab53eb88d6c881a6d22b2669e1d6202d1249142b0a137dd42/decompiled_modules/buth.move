module 0x6e22acd9b156aa5ab53eb88d6c881a6d22b2669e1d6202d1249142b0a137dd42::buth {
    struct BUTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTH>(arg0, 6, b"BUTH", b"Butherium", b"Butherium - superfast low gas blockchaim on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1778529850773.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

