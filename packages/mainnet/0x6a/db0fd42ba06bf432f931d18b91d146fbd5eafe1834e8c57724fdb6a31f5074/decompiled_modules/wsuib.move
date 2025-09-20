module 0x6adb0fd42ba06bf432f931d18b91d146fbd5eafe1834e8c57724fdb6a31f5074::wsuib {
    struct WSUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUIB>(arg0, 6, b"WSUIB", b"Wall Sui Boys", b"WALL STREET BOYS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgqrnk2c477nz2tf52r5nhivse3jnajfbhhddukpv6iw4prnd6ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WSUIB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

