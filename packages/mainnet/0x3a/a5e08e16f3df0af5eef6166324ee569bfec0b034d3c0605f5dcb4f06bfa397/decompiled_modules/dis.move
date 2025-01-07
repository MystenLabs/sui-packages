module 0x3aa5e08e16f3df0af5eef6166324ee569bfec0b034d3c0605f5dcb4f06bfa397::dis {
    struct DIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIS>(arg0, 9, b"DIS", b"dissapir", b"DISSAPIR CAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d27cd37-dfac-4526-8a75-f03fe33c4c98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

