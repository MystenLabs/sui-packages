module 0x39393aa995405d95ffd0e6f9a6748500dee49c193dba058d120a192b9bba17b7::kw {
    struct KW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KW>(arg0, 6, b"KW", b"GBCMOBILE", b"Providing a comprehensive digital currency based on digital currencies to support sustainable growth in the mobile phone and accessories sector, while providing innovative financial services to users and businesses in Kuwait and the Gulf market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730974521286.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

