module 0x645f2c35ef69a8b9be6619613b897ff8d2521a3e6bb8e0d0fb9cdf6ec5c1ab55::uptown_55 {
    struct UPTOWN_55 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPTOWN_55, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPTOWN_55>(arg0, 9, b"UPTOWN_55", b"Up Town ", b"The city of David ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d870baa-fc24-4eb6-8077-2cf17250ec5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPTOWN_55>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPTOWN_55>>(v1);
    }

    // decompiled from Move bytecode v6
}

