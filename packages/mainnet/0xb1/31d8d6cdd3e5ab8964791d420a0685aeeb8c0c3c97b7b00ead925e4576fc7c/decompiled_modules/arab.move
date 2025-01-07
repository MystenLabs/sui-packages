module 0xb131d8d6cdd3e5ab8964791d420a0685aeeb8c0c3c97b7b00ead925e4576fc7c::arab {
    struct ARAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAB>(arg0, 6, b"ARAB", b"ARAB Suiquidward", b"Inshallah we will be the best memecoin of the Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_d4d32eb3ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

