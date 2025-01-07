module 0x49c0365c97268286cc837a65fe95bea3e522ef9fdf90b87c76eb9706a847c4f6::konan {
    struct KONAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONAN>(arg0, 9, b"KONAN", b"Konan Doge", b"Introducing KONAN: The Hero Who Inspired a Revolution in Memecoins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5618fe96-b448-4e48-98fd-a2593750fac1-1000004808.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

