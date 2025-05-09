module 0xdcd443be198be7e573c536a60185464fd6cc3511933dbf5d3ce70d21e4f45ee7::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED>(arg0, 6, b"BORED", b"Bored Boyz v2", x"426f72656420426f797a206973206261636b2e0a0a4166746572206120717569636b2072657365742c20776520617265206261636b20776974682061206672657368206c6f6f6b2c2066756c6c207472616e73706172656e63792c20616e64207468652073616d652072656c656e746c65737320656e657267792e20546869732069736e2774206a7573742061206d656d65206974732061206d6f76656d656e742e0a0a57656c636f6d6520746f20626f72656420626f797a206f6e205375692e20466f72207468652063756c747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifcoe2loqxr2kwbhxu2kwo6gk7librb2htwvqxynb2652o2fd7yhm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

