module 0x8be32b939ed525827b4da5f1de5caf3afb76257ee06adefbee63b0fb6e7b1bcd::puma {
    struct PUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMA>(arg0, 6, b"PUMA", b"PUMA COIN", b"Move Like a Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicn4dggmk4jh4pk6vwy2kbony67b743puw2x6pw4jhvz6uouiyvsu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

