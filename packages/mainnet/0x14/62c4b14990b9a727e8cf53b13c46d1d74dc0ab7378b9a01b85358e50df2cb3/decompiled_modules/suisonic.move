module 0x1462c4b14990b9a727e8cf53b13c46d1d74dc0ab7378b9a01b85358e50df2cb3::suisonic {
    struct SUISONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISONIC>(arg0, 6, b"SUIsonic", b"SSSonic", b"Fast as Sonic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s3_f216fe3d49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

