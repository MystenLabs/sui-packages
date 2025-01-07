module 0x1374f5a1c264bad300b16ffc6b95fce261cd89aa916ae11b041590f984a3e8cb::ndump {
    struct NDUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDUMP>(arg0, 6, b"Ndump", b"N O  D U M P", b"NO DUMP NO DUMP NO DUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GT_7_C9_F7_XYA_Ah7xc_819d6eb914.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

