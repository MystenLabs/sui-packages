module 0xe2dfafc16c86a468cc67e93589de3b7db68e22af98e2b06ac98d35d93b881a4f::SCOIN {
    struct SCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SCOIN>, arg1: 0x2::coin::Coin<SCOIN>) {
        0x2::coin::burn<SCOIN>(arg0, arg1);
    }

    fun init(arg0: SCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOIN>(arg0, 9, b"", x"d0857569", b"Ecosystem coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdPsqEurFWTSFWPX7Nj5kTNjnreWeNJNbQf3pyjqYLBkj")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

