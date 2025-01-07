module 0xa1c063eb94c5abbac30c2556a82f007af90f92d8fac30a19ef975320c054b305::plug {
    struct PLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUG>(arg0, 6, b"Plug", b"PlugSui", b"Don't give too much meaning. enjoi the water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004701_b8c8475ee6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

