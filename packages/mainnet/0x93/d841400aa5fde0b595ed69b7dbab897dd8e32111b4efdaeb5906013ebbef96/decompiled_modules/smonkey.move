module 0x93d841400aa5fde0b595ed69b7dbab897dd8e32111b4efdaeb5906013ebbef96::smonkey {
    struct SMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMONKEY>(arg0, 6, b"SMONKEY", b"Suimonkey", b"Smooonkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1056_6a9fb20dbf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

