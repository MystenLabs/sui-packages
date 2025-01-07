module 0xe43f1567436b31a68e1b76fe87dfbb44aa257d73e45f5acc5a1a1995ebffb869::car_los {
    struct CAR_LOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAR_LOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAR_LOS>(arg0, 9, b"CAR_LOS", b"CarlsonRee", b"Kucoin meme trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e204390b-a81a-4da9-8e65-3e57f330603b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAR_LOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAR_LOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

