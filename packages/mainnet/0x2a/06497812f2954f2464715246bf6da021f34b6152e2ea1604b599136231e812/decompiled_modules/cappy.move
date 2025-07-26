module 0x2a06497812f2954f2464715246bf6da021f34b6152e2ea1604b599136231e812::cappy {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 6, b"CAPPY", b"Cappybara", b"Cappybara is meme funny on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifq62rs25qvs4uado35j7qxu2ejqmtasgkzzv3ddcupuzq7pq6pty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

