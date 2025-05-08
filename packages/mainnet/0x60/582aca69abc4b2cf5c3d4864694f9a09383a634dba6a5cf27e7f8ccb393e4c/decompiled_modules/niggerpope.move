module 0x60582aca69abc4b2cf5c3d4864694f9a09383a634dba6a5cf27e7f8ccb393e4c::niggerpope {
    struct NIGGERPOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGERPOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGERPOPE>(arg0, 6, b"NIGGERPOPE", b"SuiPope (nigger)", b"IM THE NEW POPE NIGGGER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie5ffunc7v5epxly2qwsrbvirjq4asvl5iyh3gpf3d5nuqpyov7am")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGERPOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NIGGERPOPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

