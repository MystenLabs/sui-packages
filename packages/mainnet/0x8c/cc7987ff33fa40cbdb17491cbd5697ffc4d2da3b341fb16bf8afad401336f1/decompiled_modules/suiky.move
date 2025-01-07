module 0x8ccc7987ff33fa40cbdb17491cbd5697ffc4d2da3b341fb16bf8afad401336f1::suiky {
    struct SUIKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKY>(arg0, 6, b"SUIKY", b"Suiky", b"QUACK QUACK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiky_4a004d95d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

