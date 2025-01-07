module 0x40c2f88abf30c68a3b25d267d290655b6c95ba9dd361aee7e851334ec395248d::suihorse {
    struct SUIHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHORSE>(arg0, 6, b"SUIHORSE", b"Sui Horse", b"Meet Sui Horse  Galloping through the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIHORSE_1_882115529d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

