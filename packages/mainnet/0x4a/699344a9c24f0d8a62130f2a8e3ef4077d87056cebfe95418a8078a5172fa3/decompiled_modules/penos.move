module 0x4a699344a9c24f0d8a62130f2a8e3ef4077d87056cebfe95418a8078a5172fa3::penos {
    struct PENOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENOS>(arg0, 6, b"PENOS", b"Penos Guy", b"join the $PENOS crew. We have a new vision in the midst of this very bad market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034248_32daa0a5d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

