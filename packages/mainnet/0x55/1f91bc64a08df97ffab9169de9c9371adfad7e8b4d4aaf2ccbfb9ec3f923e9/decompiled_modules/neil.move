module 0x551f91bc64a08df97ffab9169de9c9371adfad7e8b4d4aaf2ccbfb9ec3f923e9::neil {
    struct NEIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIL>(arg0, 6, b"NEIL", b"NeilArmstrong sui", b"Neil Armstrong's landing on the moon was an extraordinary thing, Neil would take part and land in the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001577_45b73b284f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

