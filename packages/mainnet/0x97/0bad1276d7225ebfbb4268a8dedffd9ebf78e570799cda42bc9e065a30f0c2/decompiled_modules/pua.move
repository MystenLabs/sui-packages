module 0x970bad1276d7225ebfbb4268a8dedffd9ebf78e570799cda42bc9e065a30f0c2::pua {
    struct PUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUA>(arg0, 6, b"PUA", b"Pua The Pig", b"Pua the pig - cute pig memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015081_142eedf68c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

