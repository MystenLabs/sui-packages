module 0x62f672b4769b907deffd2a26942f3c8d411a675d305f2527f34f08ece238612f::nopumpfun {
    struct NOPUMPFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOPUMPFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOPUMPFUN>(arg0, 6, b"Nopumpfun", b"LOOK BRO THIS IS NOT PUMPFUN", b"THIS IS NOT PUMPFUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdsdasds_922a3c18dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOPUMPFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOPUMPFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

