module 0x962315af60278fbf31f330921f55a7676a687fc38902fd7fc227f67e614e06c5::anita {
    struct ANITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANITA>(arg0, 6, b"Anita", b"Anita Max Wynn", b"Anita Max Wynn is a meme and alter ego created by Canadian rapper Drake during a December 2023", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidxh3gcbru5o4o4d564nebyvfmra2j2nxrpysqxuc5tkk2mlc5sgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANITA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

