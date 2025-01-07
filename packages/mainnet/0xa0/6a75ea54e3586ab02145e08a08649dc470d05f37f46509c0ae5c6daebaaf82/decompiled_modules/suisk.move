module 0xa06a75ea54e3586ab02145e08a08649dc470d05f37f46509c0ae5c6daebaaf82::suisk {
    struct SUISK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISK>(arg0, 6, b"SUISK", b"Elon Siusk", b"He musK come on Sui !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730670411186.26")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

