module 0x61a340cf161dfeb92b6050a8f14c64b46967fbf5a6010a734456b6c95a60038c::suimurf {
    struct SUIMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURF>(arg0, 6, b"SUIMURF", b"Sui Smurf", b"Small but mighty, $SUIMURF brings a splash of fun to the Sui Network. Blue, bold, and always up to mischief. Get smurfy with it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_24_f05f3a780a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

