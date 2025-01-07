module 0x8e4086b225d24cc84397f9e290870de23945b7bb50130cdf4de2443e46161657::doodoo {
    struct DOODOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODOO>(arg0, 6, b"DOODOO", b"DooDoo", x"492068617665206120647265616d2c20692077616e7420746f2074616b65206d7920646f6720746f2043616c69666f726e696120746f20706172746963697061746520696e2074686520616e6e75616c20646f672073757266696e6720636f6d7065746974696f6e2e0a4d7920646f672773206e616d6520697320446f6f646f6f2c2069742069732061206272617665207375726665722c20207768696368206973206120636f6f6c207468696e67206966207468617420647265616d20636f6d657320747275652e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/63b6d1ad7c4d598a6b9e301337fdfc2_f1415e2c20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOODOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

