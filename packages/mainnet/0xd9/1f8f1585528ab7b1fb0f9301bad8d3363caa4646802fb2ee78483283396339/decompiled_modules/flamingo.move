module 0xd91f8f1585528ab7b1fb0f9301bad8d3363caa4646802fb2ee78483283396339::flamingo {
    struct FLAMINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAMINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAMINGO>(arg0, 6, b"FLAMINGO", b"Flamingo Gringo On Sui", x"466c616d696e676f204772696e676f20697320746865204b696e67206f6620537569210a412076696272616e74207265616c6d2077686572652074686520736b696573206172652070696e6b20616e642074686520776174657273207368696d6d65722e2044657370697465206120746f756368206f6620656363656e747269636974792064756520746f2067656e65726174696f6e73206f6620726f79616c20696e6272656564696e672c20686520636172726965732074686520776973646f6d206f662068697320616e636573746f72732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_000713_beb9f6346c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAMINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAMINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

