module 0x4205962afb97ab730fd59ff61604183e4a03598b029432944cb097f245c52763::suri {
    struct SURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURI>(arg0, 6, b"SURI", b"$SUIRI", b"Suiri, the brave cat heroine of the Sui network, is a small but powerful protector of the digital universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiri_SUI_b84bdfa6cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURI>>(v1);
    }

    // decompiled from Move bytecode v6
}

