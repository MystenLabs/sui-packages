module 0x61d78d3d631fdb2a95962aabf073d47ae6b7e751d5cbf27b1ec0a2d14b2ec4f8::oak {
    struct OAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OAK>(arg0, 6, b"OAK", b"Professor Adeniyi Oak", b"Professor Adeniyi Oak is the wisest researcher in the Sui Region.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic6kt7hh7fyckdyyobkw3owv4bnviysv7bim3c7s2lnwieokacj5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

