module 0xb12347ace7b48ed771b12e22136294028ccadbe3cabd10bafa28ebdfd3a906f3::while {
    struct WHILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHILE>(arg0, 6, b"While", b"While the infinite loop", b"While the infinite loop is a memecoin about programming  Bugs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie4ebijiloi2leoc3mjdzlbdgpljcs4pucnrvoa7u277l3ybnvaca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHILE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

