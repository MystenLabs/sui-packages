module 0x9ecd22b4cc7f4c3fba468123c48cc61fc034031519d7077be7da2e938e359f6e::cupi {
    struct CUPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPI>(arg0, 9, b"CUPI", b"cupi xupi", b"cupi koin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b431881-cdf3-4069-8278-16c1ffe10e12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

