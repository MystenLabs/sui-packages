module 0xe770eda2694b3bd446fbc81defe2d6185c33380c8b956fc584077354cb854f00::dick69 {
    struct DICK69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK69>(arg0, 6, b"Dick69", b"DICK  8IIIIIIIIIII7", b"dick on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sfsfsf_628b6c2427.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICK69>>(v1);
    }

    // decompiled from Move bytecode v6
}

