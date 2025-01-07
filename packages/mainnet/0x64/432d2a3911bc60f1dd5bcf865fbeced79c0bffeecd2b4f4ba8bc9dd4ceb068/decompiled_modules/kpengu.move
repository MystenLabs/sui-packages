module 0x64432d2a3911bc60f1dd5bcf865fbeced79c0bffeecd2b4f4ba8bc9dd4ceb068::kpengu {
    struct KPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KPENGU>(arg0, 6, b"KPENGU", b"Karate Pengu", x"526561647920746f20756e6c656173680a796f757220696e6e65722077617272696f723f0a4a6f696e20746865204b61726174652050656e6775696e20636f6d6d756e69747920746f64617920616e6420657870657269656e63652074686520746872696c6c206f662063727970746f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/75bd74207114611_66d81af7529bf_c1ad8edb45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

