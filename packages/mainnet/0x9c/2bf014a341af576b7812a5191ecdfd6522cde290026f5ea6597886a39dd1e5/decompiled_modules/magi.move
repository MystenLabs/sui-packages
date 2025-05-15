module 0x9c2bf014a341af576b7812a5191ecdfd6522cde290026f5ea6597886a39dd1e5::magi {
    struct MAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGI>(arg0, 6, b"MAGI", b"Magikarp", x"4d6167696b6172702c20612066616d6f75736c79207573656c65737320506f6bc3a96d6f6e2e204f6e6c792063617061626c65206f6620666c6f7070696e6720616e642073706c617368696e672e2054686973206265686176696f722070726f6d7074656420646567656e7320746f20756e64657274616b6520726573656172636820696e746f2069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidfwdsmqsvtkexlxdcqfhitomru5y3gyretj4iy7rqxewe5okfwti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

