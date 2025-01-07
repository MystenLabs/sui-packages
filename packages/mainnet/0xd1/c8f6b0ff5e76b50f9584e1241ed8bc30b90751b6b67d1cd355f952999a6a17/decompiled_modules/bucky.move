module 0xd1c8f6b0ff5e76b50f9584e1241ed8bc30b90751b6b67d1cd355f952999a6a17::bucky {
    struct BUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKY>(arg0, 6, b"BUCKY", b"BUCKY DUCK", x"4255434b592069732061206475636b206f6e20737569636861696e200a4275636b7920736176652073756920666f726d206a656574626f79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BBUCKY_ac9e781cc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

