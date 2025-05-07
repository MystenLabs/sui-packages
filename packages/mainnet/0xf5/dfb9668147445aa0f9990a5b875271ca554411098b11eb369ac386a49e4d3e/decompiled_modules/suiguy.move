module 0xf5dfb9668147445aa0f9990a5b875271ca554411098b11eb369ac386a49e4d3e::suiguy {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 6, b"SuiGuy", b"THE REAL SUI GUY", b"We are real and remember the truth always comes out. Welcome to the new God of Sui Memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4c62lpsdjxgpysovmew3erarlmzwmycex7k5upjwd5z2ya24rge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

