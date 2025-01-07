module 0x7cfeba89e9fcdc8fbed201f43aee9e71be1d40e02f326124d607f8b18bd2bc84::dorkey {
    struct DORKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORKEY>(arg0, 6, b"DORKEY", b"Turkey Dog", b"He's a dorkey gobble gobble bark bark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ICON_db77632b53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

