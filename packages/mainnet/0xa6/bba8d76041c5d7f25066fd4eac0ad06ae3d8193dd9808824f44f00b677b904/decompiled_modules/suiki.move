module 0xa6bba8d76041c5d7f25066fd4eac0ad06ae3d8193dd9808824f44f00b677b904::suiki {
    struct SUIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKI>(arg0, 6, b"SUIKI", b"Suiseki", b"A Japanese art of stone appreciation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_67_933a26ce27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

