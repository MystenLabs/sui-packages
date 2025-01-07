module 0x5555d0545bf49ca9fe3fc06c7ba07cd5f8b5b7044be7eb17c6196df852bac220::hyena {
    struct HYENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYENA>(arg0, 6, b"HYENA", b"Hyena Sui", x"244859454e41202d20546865206669727374206879656e61206d656d6520636f696e0a4f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000661_074b2493f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

