module 0xce23d4ed32156ced83b955abb8ba927562b6eaf4fa165ac47505e3c121e67395::sDEEP {
    struct SDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDEEP>(arg0, 6, b"sysDEEP", b"SY sDEEP", b"SY scallop sDEEP", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDEEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDEEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

