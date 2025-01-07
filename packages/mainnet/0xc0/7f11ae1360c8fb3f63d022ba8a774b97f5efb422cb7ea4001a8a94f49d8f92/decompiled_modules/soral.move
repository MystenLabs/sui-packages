module 0xc07f11ae1360c8fb3f63d022ba8a774b97f5efb422cb7ea4001a8a94f49d8f92::soral {
    struct SORAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORAL>(arg0, 6, b"SORAL", b"SoralINU", b"SORAL INU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/soral_40d289a4f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

