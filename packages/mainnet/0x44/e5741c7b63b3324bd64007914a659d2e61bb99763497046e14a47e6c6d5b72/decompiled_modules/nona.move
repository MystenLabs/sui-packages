module 0x44e5741c7b63b3324bd64007914a659d2e61bb99763497046e14a47e6c6d5b72::nona {
    struct NONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONA>(arg0, 9, b"NONA", b"Nonan", b"No description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7af3f61f-f0c9-414e-961b-b09751cc7bc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

