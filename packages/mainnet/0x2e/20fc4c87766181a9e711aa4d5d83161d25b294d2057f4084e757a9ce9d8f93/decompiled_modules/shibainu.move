module 0x2e20fc4c87766181a9e711aa4d5d83161d25b294d2057f4084e757a9ce9d8f93::shibainu {
    struct SHIBAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBAINU>(arg0, 6, b"ShibaInu", b"SUI", b"If you love dogs, join us and send them to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012767_c5f13cde60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

