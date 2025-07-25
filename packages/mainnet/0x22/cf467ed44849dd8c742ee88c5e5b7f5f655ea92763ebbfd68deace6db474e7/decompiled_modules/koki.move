module 0x22cf467ed44849dd8c742ee88c5e5b7f5f655ea92763ebbfd68deace6db474e7::koki {
    struct KOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKI>(arg0, 6, b"KOKI", b"Koki On Sui", b"KOKI More than memecoin its a culture and many dream come true", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiegkq7dextcix2gznrryxq62qpjtwn3m4dlwdh3fmjhbx67t6pzsa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

