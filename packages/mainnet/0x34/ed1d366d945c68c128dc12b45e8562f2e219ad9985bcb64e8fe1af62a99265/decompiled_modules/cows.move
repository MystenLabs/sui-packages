module 0x34ed1d366d945c68c128dc12b45e8562f2e219ad9985bcb64e8fe1af62a99265::cows {
    struct COWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWS>(arg0, 9, b"COWS", b"COWSBOY ", b"Smart token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68de7ed2-68fb-4e9e-bef1-afd0eae32fa5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

