module 0x5e31062ec43d9bf67ff8f035b0ba6854ec046d0e549fb9ff07b4c0daf0a7c1bc::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 6, b"SAVIOR", b"Savior one", b"lfg savior now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihb4lo7f644e7gjyz4qmitewtjklagk2pcsnuar5hlojd2neuvcd4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAVIOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

