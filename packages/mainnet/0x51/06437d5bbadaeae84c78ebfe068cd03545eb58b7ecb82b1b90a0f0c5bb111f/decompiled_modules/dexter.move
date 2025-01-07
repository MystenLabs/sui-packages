module 0x5106437d5bbadaeae84c78ebfe068cd03545eb58b7ecb82b1b90a0f0c5bb111f::dexter {
    struct DEXTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEXTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEXTER>(arg0, 6, b"DEXTER", b"The Dexsters Lab", x"536369656e6365202b204d656d6573203d205265766f6c7574696f6e0a49766520636f6d62696e65642068756d6f722c206e6f7374616c6769612c20616e642063757474696e672d6564676520626c6f636b636861696e20746563686e6f6c6f677920696e746f206f6e6520756e73746f707061626c6520666f7263652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_He_YQL_Cb_400x400_5380447aa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEXTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEXTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

