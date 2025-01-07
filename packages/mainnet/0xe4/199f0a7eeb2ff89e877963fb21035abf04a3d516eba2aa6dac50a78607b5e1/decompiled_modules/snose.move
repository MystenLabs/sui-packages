module 0xe4199f0a7eeb2ff89e877963fb21035abf04a3d516eba2aa6dac50a78607b5e1::snose {
    struct SNOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOSE>(arg0, 6, b"SNOSE", b"SUI Long Nose", b"This Dog is Long af on SUI. No socials no website, just let him do it for you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/funny_3613177e27.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

