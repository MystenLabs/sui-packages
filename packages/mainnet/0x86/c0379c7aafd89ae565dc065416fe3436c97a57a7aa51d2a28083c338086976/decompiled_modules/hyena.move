module 0x86c0379c7aafd89ae565dc065416fe3436c97a57a7aa51d2a28083c338086976::hyena {
    struct HYENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYENA>(arg0, 6, b"Hyena", b"Hyena SUI", x"4879656e61206d656d65636f696e206c61756e6368696e67206f6e207375696e6574776f726b0a0a203530252041697264726f70200a20323025204c69717569646974790a20323025204d61726b6574696e670a313025205465616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fxsgptga_IAAR_0_D2_72edcb9dc1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

