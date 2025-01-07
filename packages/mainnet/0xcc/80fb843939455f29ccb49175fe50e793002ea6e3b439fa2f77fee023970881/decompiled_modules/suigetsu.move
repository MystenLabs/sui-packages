module 0xcc80fb843939455f29ccb49175fe50e793002ea6e3b439fa2f77fee023970881::suigetsu {
    struct SUIGETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGETSU>(arg0, 6, b"SUIGETSU", b"SUI GETSU", b"akatsuki suigetsu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIGETSU_67d49ab683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGETSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGETSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

