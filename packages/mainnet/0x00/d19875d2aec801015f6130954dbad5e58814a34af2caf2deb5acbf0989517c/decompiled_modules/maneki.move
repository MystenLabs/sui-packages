module 0xd19875d2aec801015f6130954dbad5e58814a34af2caf2deb5acbf0989517c::maneki {
    struct MANEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANEKI>(arg0, 6, b"Maneki", b"The Lucky Cat", b"Maneki is the lucky cat of Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1937_bb04767a73.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

