module 0xcb95219c2b33d3e4dffa8682831a3d9abb0d6c52f05c7f4834ec5d509b0a68f6::boggy {
    struct BOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGGY>(arg0, 6, b"BOGGY", b"Boggy Sui Onchain", b"Boggy: A good-natured cat who prefers to eat, trade crypto and watch TV, but is often pestered by the cockroaches & jeets of the Base network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048722_e68d5c6bc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

