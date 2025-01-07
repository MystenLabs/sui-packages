module 0x48ba1a548ce319878fb8022c432023c18b8ef6e3d4f8b5d4c45e987e55cee85d::myro {
    struct MYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYRO>(arg0, 6, b"MYRO", b"MYRO on SUI", b"Green candles is all I see!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a4n_CUPAO_400x400_6777cc3c71.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

