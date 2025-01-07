module 0x2ea18a8c13ca0048787fd9b55f89686d618f4bcde8be0bcd043d8104b43a9fd2::suimo {
    struct SUIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMO>(arg0, 6, b"SUIMO", b"Suimo", b"Ready for the mighty $SUIMO? The heavier he gets, the more force a jeet needs to exert to get us down back to the trenches. But 'till this, we are strong and steady in the Sui battlefield.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_21_55_22_7c9a1d69ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

