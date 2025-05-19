module 0x14d041b07cba1c9d05efb8c2dee814f6b6a3829cb5184633c1441990ecb7f1d9::chadie {
    struct CHADIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADIE>(arg0, 6, b"CHADIE", b"CHADIE HAS BEEN BORN", b"CHADIE The baby chad - Baby Chad has come into the world of Chads. From his bloodline of being the greatest to ape. He pursue to be like his father - A CHAD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsakrqqcamuid3fk7or4heyuz4o5dbule4dv6objzjt7ppc266gq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHADIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

