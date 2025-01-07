module 0x7a3faa1c4dacf7f5afa4a0d34de8377ba4215b57a7ecb51ebbb34d01ed90d322::bacon {
    struct BACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACON>(arg0, 6, b"BACON", b"Freddy The Bacon", b"Welcome to the Freddy The Bacon gang, if you like bacon, you are in the right place, get urself a piece of Freddy, and let's $HODL together so we can bond trough this network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_cb79aeedab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACON>>(v1);
    }

    // decompiled from Move bytecode v6
}

