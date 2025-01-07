module 0x69c9214075b0088f86bf24e6d45ecf91aa46aa72317dcd1dcee0c309fcdb5edb::suida {
    struct SUIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDA>(arg0, 6, b"SUIDA", b"Suida Sui", b"Suida, the sui panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000520_493fda30cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

