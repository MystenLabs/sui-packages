module 0x48adee8eac15171e562cd4605609bee2a2351a30eddb0b9ee2620c4538c45f19::pos {
    struct POS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POS>(arg0, 6, b"PoS", b"Proof of Steak", b"Make or buy your steak. Post it. Repeat. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ce4674f1_3fed_4169_8ff8_2a98116cc7d0_8511c76a07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POS>>(v1);
    }

    // decompiled from Move bytecode v6
}

