module 0x7589eac46954c2aba85f0a0347aaeb7b5e711cda902900f77ca23862a6575b89::mgwi {
    struct MGWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGWI>(arg0, 6, b"MGWI", b"Mogw.AI", b"Past midnight, yet the beast demands to be fed. Crafted by a past-gen, unknown AI species.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mogway00_891e7b09bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

