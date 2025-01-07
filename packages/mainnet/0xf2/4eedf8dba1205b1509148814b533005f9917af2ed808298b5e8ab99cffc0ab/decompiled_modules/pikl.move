module 0xf24eedf8dba1205b1509148814b533005f9917af2ed808298b5e8ab99cffc0ab::pikl {
    struct PIKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKL>(arg0, 6, b"PIKL", b"Mr Pickle Ball", b"$PIKL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_Yf_Ze6_PU_400x400_cda79a01ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

