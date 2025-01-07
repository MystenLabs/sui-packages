module 0x3c1f19469682eabae67a4c0d42c249e11281b10f6cdc752d16c629e46a4f4574::maneki {
    struct MANEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANEKI>(arg0, 6, b"MANEKI", b"MANEKI on SUI", x"42726577696e6720776f6e6465727320666f7220746865207765656b2c206d6167696320756e666f6c64732e2e2e0a427579206e6f77212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Afn_E_Gf96_400x400_af2579ed70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

