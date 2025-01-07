module 0x46f53f2ad516cf8dcaf4a0aaf3f991efa65c97696c287b7592a86a43673214ca::babykoi {
    struct BABYKOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYKOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYKOI>(arg0, 9, b"BABYKOI", b"Baby Koi", b"A Bold Fish Making Waves of Wealth in the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841018021047123972/RimfTUIK_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYKOI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYKOI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYKOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

