module 0xfbd226cbceed89d0b085fe8e9c88eb89226a6e0ed1079e899b86532098111b54::clown {
    struct CLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CLOWN>(arg0, 6, 0x1::string::utf8(b"CLOWN"), 0x1::string::utf8(b"clown"), 0x1::string::utf8(b"Let's have some fun and collect money"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/Q7AP92knjPkTmKi6kETxmXZESMWCICIEUg9GpiTcTG0BAQAtAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CLOWN>>(0x2::coin_registry::finalize<CLOWN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

