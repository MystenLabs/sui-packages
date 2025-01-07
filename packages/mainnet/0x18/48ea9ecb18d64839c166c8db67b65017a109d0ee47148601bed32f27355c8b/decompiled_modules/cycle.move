module 0x1848ea9ecb18d64839c166c8db67b65017a109d0ee47148601bed32f27355c8b::cycle {
    struct CYCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYCLE>(arg0, 9, b"CYCLE", b"TheSuiCycle", b"TheSuiCycle is a token symbolizing continuous growth and sustainability on the Sui blockchain. It emphasizes a regenerative process, ideal for projects centered on value circulation and innovation within digital ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1634115653337591808/8tFFyrcS.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CYCLE>(&mut v2, 1500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYCLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

