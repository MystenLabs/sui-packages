module 0x18a49c00c29da8381be887e75fccd156dbd1e0b29abf23a5eef5af5fdae6fac5::trp {
    struct TRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRP>(arg0, 6, b"TRP", b"TRAMP", b"$TRAMP TOKEN FOR THE MOTHERFUCKERS WHO FOMO IN $TRUMP AND LOSS A LOT. THIS IS FOR U! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trakmmp_e4c8317807.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

