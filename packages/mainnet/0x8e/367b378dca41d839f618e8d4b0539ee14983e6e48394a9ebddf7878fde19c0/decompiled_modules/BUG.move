module 0x8e367b378dca41d839f618e8d4b0539ee14983e6e48394a9ebddf7878fde19c0::BUG {
    struct BUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUG>(arg0, 9, b"BUG", b"BUG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUG>>(0x2::coin::mint<BUG>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

