module 0x3c779a05834971edf8990ca58e3f78a57c7e30e5e9071c99a01fed95d1ac94c2::oven {
    struct OVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVEN>(arg0, 6, b"OVEN", b"THIS WILL COOK", b"THIS IS A COOKER COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oven_f23a2e9555.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

