module 0x645f21601397b1aee0abc6eff222cce9f16bbff17f47a401dd59914de60ecb3c::vuck {
    struct VUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUCK>(arg0, 6, b"VUCK", b"Vibe duck", b"VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUCK VUXC VUCK VUCK VUCK - VIBE DUCK - $VUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056507_eb97ce7111.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

