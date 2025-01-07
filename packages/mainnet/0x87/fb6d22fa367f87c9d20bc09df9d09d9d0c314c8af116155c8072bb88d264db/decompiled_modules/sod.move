module 0x87fb6d22fa367f87c9d20bc09df9d09d9d0c314c8af116155c8072bb88d264db::sod {
    struct SOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOD>(arg0, 6, b"SOD", b"SUI ON DORKLORD", b"Prepare yourself, young Padawan, for the most epic memecoin in the $SUI galaxy: DORKLORD! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOKRLOR_d340a61312.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

