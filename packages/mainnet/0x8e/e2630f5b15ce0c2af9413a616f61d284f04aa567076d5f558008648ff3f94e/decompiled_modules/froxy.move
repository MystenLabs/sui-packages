module 0x8ee2630f5b15ce0c2af9413a616f61d284f04aa567076d5f558008648ff3f94e::froxy {
    struct FROXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROXY>(arg0, 6, b"FROXY", b"Froxy", b"Froxy is Swift as the Arctic wind, bold as the frozen tundra. A coin crafted for those who chase the wild and embrace the chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/643_a7633c0e00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

