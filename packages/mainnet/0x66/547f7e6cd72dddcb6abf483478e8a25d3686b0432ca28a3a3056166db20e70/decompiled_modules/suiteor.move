module 0x66547f7e6cd72dddcb6abf483478e8a25d3686b0432ca28a3a3056166db20e70::suiteor {
    struct SUITEOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEOR>(arg0, 6, b"Suiteor", b"Sui Meteor", b"Meteor on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a4146e511624b41a1798bf07727aedb3_f8f21ab5fb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

