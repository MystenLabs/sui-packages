module 0x821427e823a179586c7abe6c4ab6530919006d9888a80a7fe8daf5a5b61f10a3::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"SUI", b"Don't be a sad frog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012722_27c2c77767.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

