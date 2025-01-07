module 0xe8a3b975f71af1b44199bea9b61ed49314fe895aadae28c2ee8153d2758b091e::suieu {
    struct SUIEU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEU>(arg0, 6, b"SUIEU", b"SUIEUNI", b"50000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EUNI_7f13ae0c4d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEU>>(v1);
    }

    // decompiled from Move bytecode v6
}

