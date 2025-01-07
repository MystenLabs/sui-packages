module 0x18f0a5177712f82afa41eac141a306e7e31a602941e295b4d320ba67e60a5608::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"Suiper", b"SuiperScan", x"5375697065725363616e2069732061202453554920746f6b656e207363616e6e6572206f6e2054656c656772616d21200a47657420696e7374616e7420696e666f206f6e20616e79202453554920746f6b656e2e20466f72204d6f766550756d7020746f6b656e732c20636865636b20686f77206d756368207468652064657620686f6c6473206f72206966207468657927766520736f6c642120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6023687123380587709_c_0fb4a27c42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

