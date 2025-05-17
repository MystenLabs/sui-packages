module 0x691df182f737c28cf0f74f43c927d4da227c40c990aaae6edea920caae69b539::zym {
    struct ZYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYM>(arg0, 6, b"ZYM", b"Zyma Token", x"456d706f776572696e67206120677265656e657220667574757265207468726f75676820626c6f636b636861696e2e0a4f6666696369616c206163636f756e74206f66205a594d20207468652065636f2d746f6b656e20666f72207265616c20776f726c6420696d706163742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiepv7uaisae2owzeosrpdozwi4fyrpcgcxvreldsierzqgkm3qzam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZYM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

