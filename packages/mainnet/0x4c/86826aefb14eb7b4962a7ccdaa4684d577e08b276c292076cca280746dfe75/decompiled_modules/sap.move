module 0x4c86826aefb14eb7b4962a7ccdaa4684d577e08b276c292076cca280746dfe75::sap {
    struct SAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAP>(arg0, 6, b"SAP", b"SUIT ASS PUSSY", b"Got to love some suiiit  ass pussy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fap_ed79b3cf48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

