module 0xb180bbc58e16babf76bc616012bc1a00d999b8b4feb094683d800e7b69059c68::picat {
    struct PICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICAT>(arg0, 6, b"PICAT", b"PiCATchu", b"Pokemon-Cat thing on Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifitsfhqvn2ponvpymf54kyiq25fhuejxnga4iqtzwiqz5qlraabi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PICAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

