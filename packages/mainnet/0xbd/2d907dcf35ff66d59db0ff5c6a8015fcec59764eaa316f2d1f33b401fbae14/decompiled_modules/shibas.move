module 0xbd2d907dcf35ff66d59db0ff5c6a8015fcec59764eaa316f2d1f33b401fbae14::shibas {
    struct SHIBAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBAS>(arg0, 6, b"SHIBAS", b"ShibaSea", b"A  wonderful dog in the Shiba family. Ready for a fun walk? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IR_9_Ccbbq_400x400_dd0789c6c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

