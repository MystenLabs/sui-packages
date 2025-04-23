module 0x19b44d34101b235e64a96bf34beda748fe57f89a69db1cc724f0d4f7c065b23f::shabibi {
    struct SHABIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHABIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHABIBI>(arg0, 6, b"Shabibi", b"Habibi Sui", b"Habibi Sui Basecamp loading...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifrssfe3y5v26i4yk6i4ixf7inqyggkckbj3bmrdjr2nm4hxiv43m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHABIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHABIBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

