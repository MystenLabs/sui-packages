module 0xe0a9bd239bbf444ad65dc468041c549e8071a33fbc3b83b50fa15d7900942639::cptdeng {
    struct CPTDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPTDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPTDENG>(arg0, 6, b"CPTDENG", b"CPTDeng", b"CPTDeng On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CPTDENG_29e387db16.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPTDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPTDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

