module 0x5fc89982e9c5d907d3425551a57e4f03ccd30c4935a3a09bb3e5d6b86aecb79a::pigsu {
    struct PIGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGSU>(arg0, 6, b"PIGSU", b"PigSui", b"Pig Holding Dollar Bill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipig_139abcad54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

