module 0x32cbac011e1841a75af8f574c4559dcd6dcff66d7228c67024d086c4a130a151::dsmoon {
    struct DSMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSMOON>(arg0, 6, b"DSMOON", b"Dont Suilor Moon ($DSMOON)", b"Don't take it off anymore, that's enough", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_9d40221592_740c91c945.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

