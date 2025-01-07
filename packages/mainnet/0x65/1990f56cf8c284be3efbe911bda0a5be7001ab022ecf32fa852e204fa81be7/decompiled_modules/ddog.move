module 0x651990f56cf8c284be3efbe911bda0a5be7001ab022ecf32fa852e204fa81be7::ddog {
    struct DDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDOG>(arg0, 9, b"DDOG", b"Dogi", b"Fantastic dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a705dac-6c93-4917-a2fa-7cc079877e54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

