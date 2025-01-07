module 0xe364a71f9e8e00911d28a2a676d93c0ef88bda55dc7ad867f7c1c807ba075477::dildo {
    struct DILDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILDO>(arg0, 6, b"DILDO", b"dildo", b"dildo on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/17065605580_54eabddcbb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

