module 0xf8d0910e85aaf9d0d984334ad46ea606111384af27a50651cd8663cb9271494d::suimurf {
    struct SUIMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURF>(arg0, 6, b"SUIMURF", b"Suimurfe", b"Small in size, big on memecoin dreams!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_6ebfde0c6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

