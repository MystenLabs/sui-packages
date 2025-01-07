module 0x587182547c10b8bff4edab36018f62fd6d41eefb8a63fc449f3257546303ac7e::lana {
    struct LANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANA>(arg0, 9, b"LANA", b"Lana Rhoades", b"Lana Rhoades is an American internet personality, podcaster and former pornographic film actress. She has appeared in publications such as Hustler, Penthouse and Playboy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.redd.it/6xyar3ms4szc1.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LANA>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

