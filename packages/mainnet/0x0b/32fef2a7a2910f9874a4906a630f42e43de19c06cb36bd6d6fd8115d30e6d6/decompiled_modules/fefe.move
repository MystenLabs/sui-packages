module 0xb32fef2a7a2910f9874a4906a630f42e43de19c06cb36bd6d6fd8115d30e6d6::fefe {
    struct FEFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEFE>(arg0, 6, b"FEFE", b"Fefe", x"5468652053636f7270696f6e205468617420576173204e65766572204c6f7665640a0a43726561746564207468652073616d652074696d6520617320504550450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250101_040916_941_d29544b60a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

