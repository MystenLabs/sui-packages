module 0x7bb448e567ad2854dd0da96edfad71ef054279780a023ec16e78229818953704::fairy {
    struct FAIRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAIRY>(arg0, 6, b"FAIRY", b"Sui Fairy", b"$FAIRY sparkles through the Sui Network with a sprinkle of magic and charm. Small, but powerful. She brings a touch of wonder wherever she goes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_87_e5eb6e777e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAIRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

