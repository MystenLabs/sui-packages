module 0x8dd08cea487ea022f977a6a439a213b50859bc47ce05011af183abe736a63e72::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 6, b"Testing", b"Test", b"Aihua test haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeignofckz7w7whazsnmqrexlyehsgksdhk5op7fdnpkgk2gq4trgau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

