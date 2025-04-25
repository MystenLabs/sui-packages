module 0x7859ef26f97a6284385fe553a21d2d996deb4d521afe45df76587e1246856b34::lata {
    struct LATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LATA>(arg0, 6, b"Lata", b"Lelte", b"Ngdsoohgggcicidkentnf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8358_6f871537c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

