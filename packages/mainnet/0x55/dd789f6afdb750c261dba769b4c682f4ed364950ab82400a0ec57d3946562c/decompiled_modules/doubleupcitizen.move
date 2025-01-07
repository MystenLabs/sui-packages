module 0x55dd789f6afdb750c261dba769b4c682f4ed364950ab82400a0ec57d3946562c::doubleupcitizen {
    struct DOUBLEUPCITIZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUBLEUPCITIZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUBLEUPCITIZEN>(arg0, 6, b"DoubleUpCitizen", b"Adeniyi", b"Adeniyi.sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_5_T381a_EA_Acl1_Q_76c0e39105.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUBLEUPCITIZEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUBLEUPCITIZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

