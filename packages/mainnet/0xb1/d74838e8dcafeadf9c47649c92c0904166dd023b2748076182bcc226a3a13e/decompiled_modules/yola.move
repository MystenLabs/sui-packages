module 0xb1d74838e8dcafeadf9c47649c92c0904166dd023b2748076182bcc226a3a13e::yola {
    struct YOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLA>(arg0, 6, b"YOLA", b"Yolanda", b"YOLANDA AI FOR SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifdngmavk5jvxic7efgezqoqu24mai3h6rz633ng2ppjxnfsyrsa4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YOLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

