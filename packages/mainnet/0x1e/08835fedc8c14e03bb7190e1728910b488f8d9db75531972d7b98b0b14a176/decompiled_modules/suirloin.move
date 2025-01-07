module 0x1e08835fedc8c14e03bb7190e1728910b488f8d9db75531972d7b98b0b14a176::suirloin {
    struct SUIRLOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRLOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRLOIN>(arg0, 6, b"SUIRLOIN", b"suirloin", b"eat this. your blood will automatically turn blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suirloin_f6c4db6d86.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRLOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRLOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

