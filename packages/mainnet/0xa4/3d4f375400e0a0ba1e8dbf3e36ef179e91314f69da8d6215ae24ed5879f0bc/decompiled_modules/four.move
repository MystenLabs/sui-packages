module 0xa43d4f375400e0a0ba1e8dbf3e36ef179e91314f69da8d6215ae24ed5879f0bc::four {
    struct FOUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOUR>(arg0, 4, b"Four", b"4", b"CZ 4 President/Prison", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1785394282930618369/Lc45UmiV_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOUR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOUR>>(v2, @0xc2527c59dd5ae482c7d4654237c10ea900a5507211741823e572e762675785dd);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

