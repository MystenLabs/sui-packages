module 0x93cd84cc059a0b30c74aee89655f7179fa3bfe70802e4a3d0e665ad346326d9c::thirdleg {
    struct THIRDLEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIRDLEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THIRDLEG>(arg0, 6, b"Thirdleg", b"3rd Leg Guy", b"We all had one in our sports team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030454_e6fb755c01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIRDLEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THIRDLEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

