module 0xddf5524f2310c49a8d7a5a56f095cfafb5f16850191f8e83078b1fbdf4e8dccc::gamisodes {
    struct GAMISODES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMISODES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMISODES>(arg0, 6, b"Gamisodes", b"PlayGamisodes", b"Gamisodes is the \"Netflix of Interactive TV Shows.\" We're remastering the classic 1980s Inspector Gadget & transforming it into playable games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_N4_Z_Rw_1_400x400_592379a5de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMISODES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAMISODES>>(v1);
    }

    // decompiled from Move bytecode v6
}

