module 0xefa00ccf32b85cdf49081f0b6ab08370a2304478f3f7b251e35df63ea9a2f0fd::pnd {
    struct PND has drop {
        dummy_field: bool,
    }

    fun init(arg0: PND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PND>(arg0, 9, b"PND", b"pond", b"GOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/713afdb0-8e00-4ac6-b90f-5fe84c8e412b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PND>>(v1);
    }

    // decompiled from Move bytecode v6
}

