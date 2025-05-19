module 0x366fd4b9d94bea00e4d81bcf1f9e8b2fdecf4236bd403c6fd3e542fa74cb2703::sap {
    struct SAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAP>(arg0, 6, b"Sap", b"Sapper", b"Route clearing. Explosive type shit. Only invest is you know what a 12B is.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747617963648.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

