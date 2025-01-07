module 0x81875ebb12168916fac49a584a769403d5ac062c25e7bd1cfd019e1f380456eb::suifans {
    struct SUIFANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFANS>(arg0, 6, b"SUIfans", b"SUI Fans", b"The Only toke for SUIfans ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_Fans_33928a7f50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

