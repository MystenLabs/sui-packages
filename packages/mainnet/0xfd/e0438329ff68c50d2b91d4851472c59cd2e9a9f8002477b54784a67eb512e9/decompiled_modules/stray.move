module 0xfde0438329ff68c50d2b91d4851472c59cd2e9a9f8002477b54784a67eb512e9::stray {
    struct STRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAY>(arg0, 6, b"STRAY", b"Stray Dog", b"Stray Dog  ($STRAY) - A dog lost in the world, searching for a place to belong and someone to give him love and care. Join him on this journey and help him find his forever home.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723745746968_acc8130efe74d051ac03081a266ab4a7_d9fafcf789.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

