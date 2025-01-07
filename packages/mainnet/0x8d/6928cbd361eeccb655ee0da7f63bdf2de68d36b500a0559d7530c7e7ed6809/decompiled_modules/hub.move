module 0x8d6928cbd361eeccb655ee0da7f63bdf2de68d36b500a0559d7530c7e7ed6809::hub {
    struct HUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUB>(arg0, 9, b"HUB", b"HUBEST", b"just a meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dbd180b-d18e-451f-bbb4-4f00cb3cb648.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

