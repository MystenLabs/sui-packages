module 0x37780bd6fa4275940bfdd2b83a603b80578bedc231a6b55ec701c0835bb1a378::elonstar {
    struct ELONSTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONSTAR>(arg0, 6, b"ELONSTAR", b"ELONSTARLINK", b"The Starlink trend is developing in huge strides, dont miss the chance to get your 100x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_11_23_04_00_8521b52788.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONSTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONSTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

