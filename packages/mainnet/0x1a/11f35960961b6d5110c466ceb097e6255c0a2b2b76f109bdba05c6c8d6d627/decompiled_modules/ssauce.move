module 0x1a11f35960961b6d5110c466ceb097e6255c0a2b2b76f109bdba05c6c8d6d627::ssauce {
    struct SSAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAUCE>(arg0, 6, b"SSauce", b"Sui Sauce", b"Sui gas always had Sauce. Embrace it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730520656173.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSAUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

