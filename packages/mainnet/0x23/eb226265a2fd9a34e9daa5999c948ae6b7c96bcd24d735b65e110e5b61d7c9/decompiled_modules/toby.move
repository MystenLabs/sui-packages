module 0x23eb226265a2fd9a34e9daa5999c948ae6b7c96bcd24d735b65e110e5b61d7c9::toby {
    struct TOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBY>(arg0, 6, b"TOBY", b"Toby On SUI", b"TOBY - Fully Backed by Turbo Whales ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/00o_EU_13j_400x400_401f659d9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

