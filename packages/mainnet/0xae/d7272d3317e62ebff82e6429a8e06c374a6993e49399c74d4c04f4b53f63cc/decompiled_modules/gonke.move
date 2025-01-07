module 0xaed7272d3317e62ebff82e6429a8e06c374a6993e49399c74d4c04f4b53f63cc::gonke {
    struct GONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONKE>(arg0, 6, b"GONKE", b"GonkeSui", x"476f6e6b6520697320667269656e64206f6620506f6e6b652c204865206973206b696e6420666169746866756c20616e642073696c6c792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gonke_b2c1ee251d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

