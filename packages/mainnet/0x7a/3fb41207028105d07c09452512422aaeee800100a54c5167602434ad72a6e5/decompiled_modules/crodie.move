module 0x7a3fb41207028105d07c09452512422aaeee800100a54c5167602434ad72a6e5::crodie {
    struct CRODIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRODIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRODIE>(arg0, 6, b"Crodie", b"Crodiesui", b"Premier Luxury Cat Brand of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mb4t3_Vc_Y_400x400_698e6bd47f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRODIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRODIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

