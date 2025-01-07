module 0x72bd207c33378f3a1cd9936484fbd8e1179e97e4a0ba06d55fa17c0fffaa4631::lobster {
    struct LOBSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBSTER>(arg0, 5, b"LOBSTER", b"Sui Lobster", b"LOBSTER is a community coin with no intrinsic value or expectation of financial return. There is no formal team or roadmap. The coin is for entertainment purposes only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JcG6R4a.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOBSTER>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOBSTER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOBSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

