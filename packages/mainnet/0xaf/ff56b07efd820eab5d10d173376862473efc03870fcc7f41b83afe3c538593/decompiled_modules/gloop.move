module 0xafff56b07efd820eab5d10d173376862473efc03870fcc7f41b83afe3c538593::gloop {
    struct GLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOP>(arg0, 6, b"GLOOP", b"$GLOOP", b"$GLOOP on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gloop_84c97d068d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

