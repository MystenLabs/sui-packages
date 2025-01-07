module 0x70f513bf05d187c18596c165cc855cdc87ed4a4fd008faee23ac2508770934f1::jeet {
    struct JEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEET>(arg0, 6, b"Jeet", b"JEETSki", x"576520616c6c206b6e6f772061204a656574732061204a6565742c200a4a656574736b692073686f756c642062652061206c6f6e672d7465726d2070726f6a65637420746865726520776520676f696e6720746f20656e6a6f792074686973206a656574736b6920776f726c642e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021206_a8cfee5583.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

