module 0xdfbdbf82f7897e96179a6930e72bbf2f51ae7de119373e45dd3698f975ac7da0::erd {
    struct ERD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERD>(arg0, 9, b"ERD", b"ERATDEGEN", b"ERATDEGEN its a .....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7db53b8-9bfc-4da2-86f9-ac3c0b0efd9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERD>>(v1);
    }

    // decompiled from Move bytecode v6
}

