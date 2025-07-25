module 0xa9c88d7a0a5c806a983b6305a068b3f3a957f04186d89b18eca07e17afc5d2fc::scl {
    struct SCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCL>(arg0, 6, b"SCL", b"Suircle", b"Flow in the Circle, Own the Future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighjqbozjtiw4rwj65z7kslqfr5a2qer5fqtvvlcv5w3jxb6fh5om")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

