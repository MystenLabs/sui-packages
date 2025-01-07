module 0x489237d7c8ed040bd4b9c798de551f831d0924ccbb3b0032e6fcab6fec5290d6::pwengu {
    struct PWENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWENGU>(arg0, 6, b"PWENGU", b"PWENGU on Sui", x"4d656574205057454e47552c207468652064756d626573742070656e6775696e20776164646c696e67206f6e2074686520537569206e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_90_616a4c3b9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

