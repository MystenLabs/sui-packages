module 0xa9d66b7b69ddd449b00abb8ecbc739711e2acb83cb3cfafe6363eaf9d4d8bad3::gaga {
    struct GAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAGA>(arg0, 6, b"GAGA", b"SUIGAGA", b"$GAGA  the Independent wife of $PEPE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GUDG_3dv_XIAAL_0_EJ_94a139af99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

