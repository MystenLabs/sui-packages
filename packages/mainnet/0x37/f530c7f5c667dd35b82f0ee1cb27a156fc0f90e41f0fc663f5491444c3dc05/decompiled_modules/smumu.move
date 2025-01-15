module 0x37f530c7f5c667dd35b82f0ee1cb27a156fc0f90e41f0fc663f5491444c3dc05::smumu {
    struct SMUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUMU>(arg0, 6, b"SMUMU", b"MUMU", b"this is mumu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7745_9260fd5589.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

