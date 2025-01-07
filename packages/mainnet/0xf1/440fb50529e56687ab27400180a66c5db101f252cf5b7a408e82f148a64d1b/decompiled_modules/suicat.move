module 0xf1440fb50529e56687ab27400180a66c5db101f252cf5b7a408e82f148a64d1b::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"BLUE CAT", x"68747470733a2f2f742e6d652f737569636174706f7274616c0a68747470733a2f2f7375696361742e66756e2f0a68747470733a2f2f782e636f6d2f537569436174636f696e0a0a546865204f472043617420436f696e206f6e205375690a47657420696e206f6e207468652067726f756e6420666c6f6f722077697468205375692043617420616e642062652070617274206f6620746865204f472063617420636f696e207265766f6c7574696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3607_9509b6a36a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

