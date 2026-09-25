module 0x14191da22560f3256be5d0d4ad41687aac0cd99e4e748e75d1243e3f8c88985d::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPP>(arg0, 9, b"PPP", b"PPP", b"Blast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/4o249b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PPP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PPP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PPP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

