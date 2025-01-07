module 0xc586b7316069a544bf07c79892597fa0beca08783bc5ec3a5851931caa19848::aquaman {
    struct AQUAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAMAN>(arg0, 6, b"AQUAMAN", b"AQUAMAN TEAM", x"546865204e756d626572203120446566656e646572206f662074686520535549206d656d6520556e6976657273652e0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3591_03cf9cc59d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

