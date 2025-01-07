module 0xa75000c65f7d9bbf8d8bba8a69aed02157543b272d07ccbef2b20790d996f7c5::shake {
    struct SHAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAKE>(arg0, 6, b"SHAKE", b"shake", b"Shake the Shark Pepe! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_c82fbae8b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

