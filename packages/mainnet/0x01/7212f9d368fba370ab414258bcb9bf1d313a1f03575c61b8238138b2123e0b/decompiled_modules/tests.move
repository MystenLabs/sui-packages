module 0x17212f9d368fba370ab414258bcb9bf1d313a1f03575c61b8238138b2123e0b::tests {
    struct TESTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTS>(arg0, 6, b"Tests", b"test", b"Testst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihcqr544m2bvburxi4dprwx7mkdvquhn3czzeansbqwn5top5spyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

