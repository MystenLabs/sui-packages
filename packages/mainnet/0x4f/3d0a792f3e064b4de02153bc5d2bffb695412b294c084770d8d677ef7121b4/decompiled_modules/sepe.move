module 0x4f3d0a792f3e064b4de02153bc5d2bffb695412b294c084770d8d677ef7121b4::sepe {
    struct SEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEPE>(arg0, 6, b"Sepe", b"sepe", b"sui pepe for the ones who missed the pepe train", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sepe_3c2eca9f77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

