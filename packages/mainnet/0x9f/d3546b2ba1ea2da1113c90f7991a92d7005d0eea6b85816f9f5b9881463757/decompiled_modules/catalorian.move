module 0x9fd3546b2ba1ea2da1113c90f7991a92d7005d0eea6b85816f9f5b9881463757::catalorian {
    struct CATALORIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATALORIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATALORIAN>(arg0, 6, b"CATALORIAN", b"Catalorianonsui", b"The First CATALORIAN Launched on the sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zwl_Up_Kql_400x400_217d61d39d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATALORIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATALORIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

