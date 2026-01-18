module 0xf93a3ff926c758e2b163ea36b4183a1d067ab8db70017bc5d430ec2ecd972a37::ptech {
    struct PTECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTECH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTECH>(arg0, 6, b"PTECH", b"Maduro Pepe", b"Pepe is ready for any turn of events. The ultimate Nike Tech meta on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000422421_4933d8f702.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTECH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTECH>>(v1);
    }

    // decompiled from Move bytecode v6
}

