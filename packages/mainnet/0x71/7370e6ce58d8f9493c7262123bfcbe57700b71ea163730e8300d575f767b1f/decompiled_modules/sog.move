module 0x717370e6ce58d8f9493c7262123bfcbe57700b71ea163730e8300d575f767b1f::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SOG", b"Sui Mog Coin", b"SOG, Sui Mog Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaulsy4oqhqnhqaaxyeudyqyaroum7ca7ggucerlc45fhkrc2kaja")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

