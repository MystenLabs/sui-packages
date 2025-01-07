module 0xfc231ddfd2e19a64803c0a1311674e4f860c51a776aaebc6365f8341e573f667::l {
    struct L has drop {
        dummy_field: bool,
    }

    fun init(arg0: L, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L>(arg0, 6, b"L", b"Luigi", b"https://www.justice.gov/opa/pr/luigi-mangione-charged-stalking-and-murder-unitedhealthcare-ceo-brian-thompson-and-use", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/729ae1375722be563d9121dc1b57715_b8f213d129.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<L>>(v1);
    }

    // decompiled from Move bytecode v6
}

