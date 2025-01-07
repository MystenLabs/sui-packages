module 0x70849fda6ef56fd371f21796cf9484b1e95e840adedc6a799b2644e479ae11ad::bitsui {
    struct BITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITSUI>(arg0, 6, b"BITSUI", b"BikiniBitcoinSuiWifHat", b"BikiniBitcoinSuiWifHat x10,000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_12_18_25_ff17f97949.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

