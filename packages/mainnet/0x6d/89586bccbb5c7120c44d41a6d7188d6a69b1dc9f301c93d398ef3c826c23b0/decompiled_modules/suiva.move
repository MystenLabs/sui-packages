module 0x6d89586bccbb5c7120c44d41a6d7188d6a69b1dc9f301c93d398ef3c826c23b0::suiva {
    struct SUIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVA>(arg0, 6, b"SUIVA", b"SHIVA", b"Relaunch. The last one was a mistake. Sorry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiva_4ea77726c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

