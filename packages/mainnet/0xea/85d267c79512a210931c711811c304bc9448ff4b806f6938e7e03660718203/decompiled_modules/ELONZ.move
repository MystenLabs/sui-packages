module 0xea85d267c79512a210931c711811c304bc9448ff4b806f6938e7e03660718203::ELONZ {
    struct ELONZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONZ>(arg0, 6, b"Elon Rizz", b"ELONZ", b"Elon is a genius that was able to create AI girls that will help rebuild Mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

