module 0x8e5d07f5b56ddcd7be86bae64e46df0b57d887f2a576ca619bdfe213356653bc::stesa {
    struct STESA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STESA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STESA>(arg0, 6, b"Stesa", b"tesa", b"tes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8530682_88386b2c03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STESA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STESA>>(v1);
    }

    // decompiled from Move bytecode v6
}

