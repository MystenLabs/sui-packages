module 0x93c578e1fab579a459c2aaa4cccaacce0154a21fd7450e17b8173ef60e3faccd::boggs {
    struct BOGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGGS>(arg0, 6, b"BOGGS", b"The Land Of Boggs", b"The Land of Boggs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014945_5fcea295cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

