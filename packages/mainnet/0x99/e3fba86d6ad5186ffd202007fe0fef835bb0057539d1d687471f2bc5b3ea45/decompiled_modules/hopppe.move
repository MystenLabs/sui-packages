module 0x99e3fba86d6ad5186ffd202007fe0fef835bb0057539d1d687471f2bc5b3ea45::hopppe {
    struct HOPPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPPE>(arg0, 6, b"HOPPPE", b"DAEQ", b"FASF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990988270.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPPPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

