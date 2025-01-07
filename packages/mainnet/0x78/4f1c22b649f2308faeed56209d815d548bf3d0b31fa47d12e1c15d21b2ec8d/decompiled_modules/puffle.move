module 0x784f1c22b649f2308faeed56209d815d548bf3d0b31fa47d12e1c15d21b2ec8d::puffle {
    struct PUFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFLE>(arg0, 6, b"Puffle", b"PUFFLE", b"Puffle is a memecoin designed to create a secure and transparent ecosystem for crypto users. Utilizing the MovePump platform, Puffle ensures that 100% of the total supply goes directly into liquidity. By leveraging the Sui blockchain technology, Puffle offers fast transactions, low fees, and high security, making it an ideal choice for crypto traders and investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241019_111735_dd41a6835b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

