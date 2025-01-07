module 0x3b1793fc632a4bb87bc078034c7170dd90067aea88fc041f3644d536ddbac839::bike {
    struct BIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIKE>(arg0, 9, b"BIKE", b"Bike fall", b"Falling off bike, stick in bike wheel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba8000e8-f2f5-493b-b567-ee2032f6696e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

