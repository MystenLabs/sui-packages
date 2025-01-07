module 0x72ae17da0bc7a8e0f1979e48acd47710094fcf3438707f69a6e04e144d41336a::sba {
    struct SBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBA>(arg0, 9, b"SBA", b"vann samba", b"Build with smart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a83ea47d-10b4-46b2-a7dd-0ebdabf9ef99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

