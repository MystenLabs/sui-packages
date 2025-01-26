module 0x99958a0d01e67f87941d5f6f9161dfd1136fc56a35098b38d6f0ef6f8cbf29c5::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTHING>(arg0, 9, b"nothing", b"probably nothing", x"536f6369616c466920796f75722063616c6c7320616e642067657420246e6f7468696e6720696e2072657475726e0d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmV8CrPMKfS8YrEoop6T95SzhayCU1EUZvv7RZqmRXpYtg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOTHING>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTHING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

