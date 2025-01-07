module 0x6b3e6e682d4fc31509ae25544bf2dcb2ed3232d9f377857e73029656419d054::moose {
    struct MOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSE>(arg0, 6, b"MOOSE", b"SMUGGOAT", b"A smug goat named $MOOSE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ba_V_Ta_Bo9_400x400_e8b198173e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

