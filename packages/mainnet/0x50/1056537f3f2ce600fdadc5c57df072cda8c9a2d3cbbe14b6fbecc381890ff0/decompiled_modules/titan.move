module 0x501056537f3f2ce600fdadc5c57df072cda8c9a2d3cbbe14b6fbecc381890ff0::titan {
    struct TITAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITAN>(arg0, 6, b"TITAN", b"Titan Infinity", b" $Titan, wields the Crypto Gauntlet, holding the power of every major cryptocurrency at his fingertips. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/thanosui_55a7eaa491.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

