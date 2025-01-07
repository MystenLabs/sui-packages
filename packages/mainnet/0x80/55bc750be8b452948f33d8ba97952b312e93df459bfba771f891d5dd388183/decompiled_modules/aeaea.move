module 0x8055bc750be8b452948f33d8ba97952b312e93df459bfba771f891d5dd388183::aeaea {
    struct AEAEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEAEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEAEA>(arg0, 6, b"Aeaea", b"gdgdgd", b"gd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADA_3_f3b2da2a59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEAEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEAEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

