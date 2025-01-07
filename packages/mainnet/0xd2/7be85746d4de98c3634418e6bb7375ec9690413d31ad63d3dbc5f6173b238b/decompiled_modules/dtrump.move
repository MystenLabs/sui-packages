module 0xd27be85746d4de98c3634418e6bb7375ec9690413d31ad63d3dbc5f6173b238b::dtrump {
    struct DTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTRUMP>(arg0, 6, b"DTRUMP", b"DogTrump", b"First American Dog president", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241115_185735_887_f124bfdf03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

