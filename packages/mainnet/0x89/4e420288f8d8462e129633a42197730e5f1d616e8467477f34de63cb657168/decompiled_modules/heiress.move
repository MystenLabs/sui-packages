module 0x894e420288f8d8462e129633a42197730e5f1d616e8467477f34de63cb657168::heiress {
    struct HEIRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEIRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEIRESS>(arg0, 6, b"Heiress", b"Heiress Ai", x"7374796c6973682066616365206f662063727970746f206f6e207468652053756920626c6f636b636861696e2e204669657263652c20616d626974696f75732c20616e6420756e73746f707061626c652c2073686573206865726520746f20656d706f77657220686f6c6465727320616e64206d616b6520776176657320696e20576562332e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018695_66af36ad3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEIRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEIRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

