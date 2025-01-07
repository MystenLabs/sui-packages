module 0x9ce565daf51386b7c354b4d1c90ebc29f102e0c387818557e7fc863dba26348b::catos {
    struct CATOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATOS>(arg0, 6, b"CATOS", b"CATONYMOUS", b"CAT, CATHO AND ANONYMOUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4032_62bf3dd969.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

