module 0x4ff0f5d875cd2c6a8ae4df7d43e086b174a73b8a3ce2c094ed4bb009751b54df::suicumber {
    struct SUICUMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUMBER>(arg0, 6, b"SUiCUMBER", b"SUICUMBER", b"Suicumber isn't blue, so what? will that stop him from becoming one of SUI's best? Certainly not.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/od_J_Eei_MO_400x400_79d4443338.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

