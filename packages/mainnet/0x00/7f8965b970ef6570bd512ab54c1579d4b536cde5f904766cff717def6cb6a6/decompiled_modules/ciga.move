module 0x7f8965b970ef6570bd512ab54c1579d4b536cde5f904766cff717def6cb6a6::ciga {
    struct CIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIGA>(arg0, 6, b"CIGA", b"Cat chigga", b"Meow yo cum in my mouth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2408b098b780db3cff4b1d69268a458b_55687ebf64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

