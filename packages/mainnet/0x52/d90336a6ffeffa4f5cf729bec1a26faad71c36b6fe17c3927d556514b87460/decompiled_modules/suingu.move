module 0x52d90336a6ffeffa4f5cf729bec1a26faad71c36b6fe17c3927d556514b87460::suingu {
    struct SUINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGU>(arg0, 6, b"Suingu", b"suingu", b"the Penguin of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suingu_34ea681a70_165434c73a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

