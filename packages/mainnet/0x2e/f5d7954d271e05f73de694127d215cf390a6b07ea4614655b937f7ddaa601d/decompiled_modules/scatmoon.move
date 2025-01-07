module 0x2ef5d7954d271e05f73de694127d215cf390a6b07ea4614655b937f7ddaa601d::scatmoon {
    struct SCATMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCATMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCATMOON>(arg0, 6, b"SCATMOON", b"SUI CAT MOON", b"$SCATMOON, the adventurous cat that conquers the moon and sails through the Sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicatmoon_16fda412b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCATMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCATMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

