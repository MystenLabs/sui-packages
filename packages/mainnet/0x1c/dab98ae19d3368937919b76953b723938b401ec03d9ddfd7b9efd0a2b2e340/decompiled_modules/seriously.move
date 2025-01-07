module 0x1cdab98ae19d3368937919b76953b723938b401ec03d9ddfd7b9efd0a2b2e340::seriously {
    struct SERIOUSLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERIOUSLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERIOUSLY>(arg0, 6, b"SERIOUSLY", b"THISISNOTASCAM.AI", b"Really!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_swear_85fe097d19.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SERIOUSLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SERIOUSLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

