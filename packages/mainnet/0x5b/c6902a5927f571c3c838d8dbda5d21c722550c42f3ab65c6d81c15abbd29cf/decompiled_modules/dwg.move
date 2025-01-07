module 0x5bc6902a5927f571c3c838d8dbda5d21c722550c42f3ab65c6d81c15abbd29cf::dwg {
    struct DWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWG>(arg0, 6, b"DWG", b"DOG WIF GOGGLES", b"dog going for swim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_4_1f9bcdbd13.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

