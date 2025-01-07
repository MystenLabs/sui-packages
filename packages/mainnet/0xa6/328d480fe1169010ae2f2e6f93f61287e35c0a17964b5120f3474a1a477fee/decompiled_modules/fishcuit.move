module 0xa6328d480fe1169010ae2f2e6f93f61287e35c0a17964b5120f3474a1a477fee::fishcuit {
    struct FISHCUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHCUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHCUIT>(arg0, 6, b"FISHCUIT", b"Fishcuit On Sui", x"4046697368637569744f6e5375690a68747470733a2f2f742e6d652f66697368637569740a66697368637569742e78797a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_G7_L64_TV_400x400_3cf68dd114.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHCUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHCUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

