module 0xef9b43454111e106a2a964dbbcb2d0c2a21d32ddf89b280fc4c5e6c31f3aab2c::crack {
    struct CRACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRACK>(arg0, 6, b"CRACK", b"CrackFish", b"just a crack fish in the cracksea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibtkgi3nxmfelykp6ltw3af7ltqkhmbwtx3efypgratb2dfewl2oe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRACK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

