module 0x63811893535017018d3f83d9e408c9ecad7bfeb022fda4e21b12617cd7b09e16::europa {
    struct EUROPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUROPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUROPA>(arg0, 6, b"Europa", b"europa", b"Jupiter's moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004799_959b9f4dff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUROPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUROPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

