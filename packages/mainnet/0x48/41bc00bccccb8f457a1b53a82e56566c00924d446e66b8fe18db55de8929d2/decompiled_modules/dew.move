module 0x4841bc00bccccb8f457a1b53a82e56566c00924d446e66b8fe18db55de8929d2::dew {
    struct DEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEW>(arg0, 6, b"DEW", b"DEW on SUI", x"444557206f6e205355490a0a44796e616d69632043726f737320436861696e2045786368616e67652057616c6c6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736056137030.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

