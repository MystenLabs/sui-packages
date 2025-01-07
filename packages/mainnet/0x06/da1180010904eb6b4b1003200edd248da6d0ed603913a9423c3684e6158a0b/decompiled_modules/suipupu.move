module 0x6da1180010904eb6b4b1003200edd248da6d0ed603913a9423c3684e6158a0b::suipupu {
    struct SUIPUPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUPU>(arg0, 6, b"SuiPuPu", b"SUIPUPU", x"5373686820646f6e742074656c6c20616e796f6e65206275742049207468696e6b202450555055206973202e2e2e200a4d6f737420736572696f75732070726f6a656374206f6e2024535549200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241012_162115_706_4f5a288450.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

