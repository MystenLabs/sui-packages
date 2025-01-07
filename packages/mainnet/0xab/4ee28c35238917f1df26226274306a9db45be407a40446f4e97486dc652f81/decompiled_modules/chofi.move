module 0xab4ee28c35238917f1df26226274306a9db45be407a40446f4e97486dc652f81::chofi {
    struct CHOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOFI>(arg0, 6, b"CHOFI", b"Choad fi", b"LoFi's Choad, its a movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_a873dd9905.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

