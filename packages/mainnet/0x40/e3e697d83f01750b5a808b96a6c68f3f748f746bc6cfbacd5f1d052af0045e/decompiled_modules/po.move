module 0x40e3e697d83f01750b5a808b96a6c68f3f748f746bc6cfbacd5f1d052af0045e::po {
    struct PO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PO>(arg0, 6, b"PO", b"Pixel Origin", x"0a506978656c73206172652074686520736d616c6c65737420756e697420696e206469676974616c20696d61676520726570726573656e746174696f6e2e204561636820706978656c206861732061206e756d65726963616c2076616c756520746861742064657465726d696e65732069747320636f6c6f7220616e6420696e74656e736974792e20416e64206865726520706978656c7320617265206368617261637465727320696e204e46542e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Banner_42d6fe9b5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PO>>(v1);
    }

    // decompiled from Move bytecode v6
}

