module 0x62887a893f6c048a94a37ff463c016170ad62afe3e249f466a3af33dc6429b20::emc {
    struct EMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMC>(arg0, 6, b"EMC", b"ELONg MUSKy COIN", b"ELONg MUSKys official pump token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_23_061925_8b1c3451ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

