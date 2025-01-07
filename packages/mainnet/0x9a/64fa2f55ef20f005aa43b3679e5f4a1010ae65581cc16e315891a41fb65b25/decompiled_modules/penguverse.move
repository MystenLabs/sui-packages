module 0x9a64fa2f55ef20f005aa43b3679e5f4a1010ae65581cc16e315891a41fb65b25::penguverse {
    struct PENGUVERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUVERSE>(arg0, 6, b"Penguverse", b"Pengu Universe", b"First Pengu Universe on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d3eab849012685_58a860b3bc590_ae9d92f7ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUVERSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUVERSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

