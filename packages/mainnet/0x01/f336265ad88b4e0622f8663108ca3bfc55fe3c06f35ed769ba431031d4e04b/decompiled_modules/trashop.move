module 0x1f336265ad88b4e0622f8663108ca3bfc55fe3c06f35ed769ba431031d4e04b::trashop {
    struct TRASHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRASHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRASHOP>(arg0, 6, b"TRASHOP", b"TRAS HOP FUN", b"HOP.FUN IS A GARBAGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HOPPP_f5f50de602.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRASHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRASHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

