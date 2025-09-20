module 0x783cfe3a68a2d269b674113addf64caed7334acafab666bf725df3287d800283::wae {
    struct WAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAE>(arg0, 6, b"WAE", b"WAE Berlin", b"Rolling bearings, drive elements, sensors, roller chains, V-belts, sprockets, and industrial supplies Monopoly company from Berlin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1758404281203.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

