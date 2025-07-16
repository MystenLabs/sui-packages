module 0x3082e319cd6ae8325a992fdfc77296ed2c29ca4509145520e6206712ae4c87aa::Diuqs {
    struct DIUQS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIUQS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIUQS>(arg0, 9, b"SQUID1", b"Diuqs", b"squid backwards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/932313014241435648/cDpqFAqZ_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIUQS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIUQS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

