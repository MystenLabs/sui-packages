module 0xe49d7e2806815c16137e8c7e7f0ec4f3e0fefc0796517671e4354ce0961bd0a8::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"Uni", b"Meet Uni - Named after Sui co-founder Evan Cheng's dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xaf9e228fd0292e2a27b4859bc57a2f3a9faedb9341b6307c84fef163e44790cc_uni_uni_bff67de4ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

