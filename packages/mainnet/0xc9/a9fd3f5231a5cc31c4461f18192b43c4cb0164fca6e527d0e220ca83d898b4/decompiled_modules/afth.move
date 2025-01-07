module 0xc9a9fd3f5231a5cc31c4461f18192b43c4cb0164fca6e527d0e220ca83d898b4::afth {
    struct AFTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFTH>(arg0, 6, b"AFTH", b"AftermathFi", b"Also known as \"Interesting Yolks\" Built on #SuiMove #BetterThanCEX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_76e74bf992.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

