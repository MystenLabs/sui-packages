module 0xfb72838e377488117710612d4bde4e064cc882d2b2d27855d88f7c90952db33c::gndd {
    struct GNDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNDD>(arg0, 6, b"GNDD", b"Grandads", b"Son, you're at the right place. We got them vibes you've been looking for.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/king_a29d54b5ce.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

