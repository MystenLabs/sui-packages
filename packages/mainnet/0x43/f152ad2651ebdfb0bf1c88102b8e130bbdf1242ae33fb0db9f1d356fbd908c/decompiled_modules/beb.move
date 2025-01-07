module 0x43f152ad2651ebdfb0bf1c88102b8e130bbdf1242ae33fb0db9f1d356fbd908c::beb {
    struct BEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEB>(arg0, 9, b"BEB", b"Bebe", b"The meme coin that will bring tremendous value to the SUI ecosystem. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae06c0f1-8d4e-44e3-8bdc-a88a3ffdf296.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

