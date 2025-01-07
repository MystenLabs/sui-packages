module 0xa084e924a0fb11fa71c0633cc693b7b4176dd970d7e24ffbba9ae75d0756dd5::tpe {
    struct TPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPE>(arg0, 6, b"TPE", b"TRUMPE", b"47th President of America on turbo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958111844.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

