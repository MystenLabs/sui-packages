module 0xffe1b33f29e4e2dc9bbda1bef2e29a7eabad3f67709e8c2dce480d1503ab5c02::while {
    struct WHILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHILE>(arg0, 6, b"While", b"While the infinite loop", b"While the infinite loop , is a memecoin about programming bugs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie4ebijiloi2leoc3mjdzlbdgpljcs4pucnrvoa7u277l3ybnvaca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHILE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

