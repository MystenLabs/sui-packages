module 0x7c810a22e6d7b5e7b8756d65b3bf27b5a46deef6876e1ac65b41a449fc9642ee::prime {
    struct PRIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIME>(arg0, 9, b"PRIME", b"Optimus", b"The Prime token on Sui grants early access to a fast blockchain and exclusive Sui-based DApps, positioning you at the forefront of innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841153200688074755/HU0WuOuL.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRIME>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

