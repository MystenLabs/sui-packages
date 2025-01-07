module 0xb293804bdb89a485d872a39ec798af5270ccaaebf34f367d66d0c607d892221b::rats {
    struct RATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATS>(arg0, 6, b"RATS", b"SUIRATS", x"535549524154532069732061206361707469766174696e67206d656d65636f696e206d616b696e6720776176657320696e207468652063727970746f20776f726c642e205769746820612076696272616e7420636f6d6d756e69747920616e642067726f77746820706f74656e7469616c2c20697427732061636365737369626c6520616e642072656c617461626c652e204a6f696e2074686520535549524154207265766f6c7574696f6e20616e642062652070617274206f6620736f6d657468696e67207370656369616c2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_13_54_56_eac1ed9a4a_1b4c49617b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

