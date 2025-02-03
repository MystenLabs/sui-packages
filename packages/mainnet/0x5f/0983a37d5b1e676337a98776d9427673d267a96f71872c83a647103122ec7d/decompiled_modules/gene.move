module 0x5f0983a37d5b1e676337a98776d9427673d267a96f71872c83a647103122ec7d::gene {
    struct GENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENE>(arg0, 6, b"GENE", b"Gene AI", x"5468652047454e4520746f6b656e20676976657320686f6c646572732061636365737320746f2047454e452773206e6574776f726b206f6620736369656e746966696320636f6d6d756e697469657320616e642049502c20656e61626c696e672062726f6164206578706f7375726520746f207468652044655363692065636f6e6f6d792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738464776546.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

