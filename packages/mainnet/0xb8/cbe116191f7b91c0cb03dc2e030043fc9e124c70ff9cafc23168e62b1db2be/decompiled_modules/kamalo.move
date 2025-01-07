module 0xb8cbe116191f7b91c0cb03dc2e030043fc9e124c70ff9cafc23168e62b1db2be::kamalo {
    struct KAMALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALO>(arg0, 6, b"KAMALO", b"KAMALO HORRIS", b"POTUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GUUS_3d_OXUA_Azd_Y_45dfabe98f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

