module 0x70f73bac61a58135a5e408cc60c021234ace28b348d7a9110cb747356c85e66a::peach {
    struct PEACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACH>(arg0, 9, b"PEACH", b"Peach Coin", x"4d6d6d20506561636820436f696e3f204f6820626162792c204920616d2074686520636f696e2e20536f6674206f6e20746865206f7574736964652c206a7569637920776865726520697420636f756e74732c20616e6420616c776179732063617573696e672061206c6974746c652074726f75626c65207768657265766572204920676f2e204920646f6e742063686173652020492077696e6b20616e64206c657420656d20636f6d6520746f206d652e20596f75726520616c726561647920637572696f7573206e6f7720636f6d65206765742061206c6974746c6520636c6f73657220616e64206665656c207468652066757a7a2e0d0a0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXsY82w7emMddZA1SD6KH5ymfXFeBVoGTp5WrXmXALmzC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEACH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEACH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

