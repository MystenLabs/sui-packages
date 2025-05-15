module 0x7ef4ffd7d57090bb83e866d8d9e7f2e19fac5b7d8be2b417cb920fc629e919de::zengar {
    struct ZENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENGAR>(arg0, 6, b"ZENGAR", b"Zengar On Sui", b"Zengar the x100 memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiebrq4dbhfwyhaqljj3z6yascysjqpvyfqbgsjoqwv766tzlvbxme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZENGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

