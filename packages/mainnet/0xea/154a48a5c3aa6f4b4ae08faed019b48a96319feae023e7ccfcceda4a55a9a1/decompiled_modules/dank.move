module 0xea154a48a5c3aa6f4b4ae08faed019b48a96319feae023e7ccfcceda4a55a9a1::dank {
    struct DANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANK>(arg0, 6, b"DANK", b"Dank Memes", b"where it all began IYKYK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidkvdrmblcwf3g2y4aj3fgaujw4hlseeskrzh2czhpx23bwjric64")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DANK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

