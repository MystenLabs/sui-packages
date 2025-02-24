module 0xa400d768e93f02cd6dee132bdbb1720ddbf910073770f6e99fa958917dab3e7c::elon1 {
    struct ELON1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON1>(arg0, 6, b"ELON1", b"elon", b"elon is a good man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elon_Musk_Royal_Society_cropped_41c8e72e5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELON1>>(v1);
    }

    // decompiled from Move bytecode v6
}

