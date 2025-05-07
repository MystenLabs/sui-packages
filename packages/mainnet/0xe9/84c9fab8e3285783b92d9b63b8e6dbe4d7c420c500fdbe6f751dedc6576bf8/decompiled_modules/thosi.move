module 0xe984c9fab8e3285783b92d9b63b8e6dbe4d7c420c500fdbe6f751dedc6576bf8::thosi {
    struct THOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOSI>(arg0, 6, b"THOSI", b"THOSISUI", b"Thosi meme coin on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif74qabii5k2e2olke6tcjhqv4om3jw2elusqwnjrwfqy27r33qmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THOSI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

