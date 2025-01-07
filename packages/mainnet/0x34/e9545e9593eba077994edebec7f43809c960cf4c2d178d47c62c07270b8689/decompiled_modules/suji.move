module 0x34e9545e9593eba077994edebec7f43809c960cf4c2d178d47c62c07270b8689::suji {
    struct SUJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUJI>(arg0, 6, b"SUJI", b"Suji", b"The cute dinosaur of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Goji_5a10532bb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

