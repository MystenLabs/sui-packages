module 0x76fc85b002d587da1b2c6458fcc80da79fe335415bead3c58c85c2ceba598dbd::elontrump {
    struct ELONTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONTRUMP>(arg0, 6, b"ELONTRUMP", b"ELON X TRUMP", x"456c6f6e2078205472756d70204472616d6120546f6b656e20284558545329206f6e205375690a45585453206f6e207468652053756920626c6f636b636861696e20636170747572657320746865206578706c6f7369766520323032352066657564206265747765656e20456c6f6e204d75736b20616e6420446f6e616c64205472756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieoitvu7kvtdzcghqogntahpzw72ph72nmkmkwwkd2lx52biosiqa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELONTRUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

