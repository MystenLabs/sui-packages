module 0xf2d97a182dbf52e6e9c912e512552da097186b2c0a7762f5fcba0b92d8529a3f::wcute {
    struct WCUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCUTE>(arg0, 6, b"WCUTE", b"Walrus Cute", b"The Cutest walrus launch on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cutwalrus_6c65c3dd68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

