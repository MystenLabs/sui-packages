module 0xe62db93e233a4cb4ca769345709436c10916a0ff243cb5b4e401e24ca772a7fd::wedog {
    struct WEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOG>(arg0, 9, b"WEDOG", b"WEWE DOG", b"First Dog to WEWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54b4cd08-a6da-4799-a5db-2caf63fdcf06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

