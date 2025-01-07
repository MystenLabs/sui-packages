module 0xa3747a37e402a6ba10d53ac34997b9c37d661b8e60ce3f3d3ada5b69cc68ecb7::squishy {
    struct SQUISHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUISHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUISHY>(arg0, 9, b"SQUISHY", b"SquishytheSquid", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwEbEFt71R-pcGnAGpohXwAMOp5OGiZHAPLw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUISHY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUISHY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUISHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

