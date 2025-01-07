module 0xb9c7284897aa22853382a5fb74e4b174cbee0e11d30086ebcdb3780747d23799::pdogs {
    struct PDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOGS>(arg0, 6, b"PDOGS", b"Panxer doga", b"Panxer dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241124_013108_c05f60b02d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

