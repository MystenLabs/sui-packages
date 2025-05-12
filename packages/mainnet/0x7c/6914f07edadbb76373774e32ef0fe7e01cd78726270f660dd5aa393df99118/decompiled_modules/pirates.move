module 0x7c6914f07edadbb76373774e32ef0fe7e01cd78726270f660dd5aa393df99118::pirates {
    struct PIRATES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATES>(arg0, 6, b"PIRATES", b"Pirates Island", b"Set sail on the wild seas of the Sui blockchain with Pirates Island, the ultimate meme powered adventure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicnuqvz4lco3tpdpfed2ivotoushd5pi4ijyarsopobbwyb3htvhy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIRATES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

