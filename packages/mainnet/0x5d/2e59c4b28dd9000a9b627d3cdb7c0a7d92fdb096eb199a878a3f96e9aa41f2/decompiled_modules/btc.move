module 0x5d2e59c4b28dd9000a9b627d3cdb7c0a7d92fdb096eb199a878a3f96e9aa41f2::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"BITCOIN TRADER CAT", x"24425443202d2054484520424954434f494e2054524144455220434154202c2057484f204c494b455320544f20534d4f4b45205745454420414e44204452494e4b20424545522c2049542043414e204245205345454e2042592048495320464154204153532c20535455504944204e4f4f4220464143452c20505550504554204641524d2043415420425553204953204845524520544f20524f434b20210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_14_08_24_4be6f99274.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

