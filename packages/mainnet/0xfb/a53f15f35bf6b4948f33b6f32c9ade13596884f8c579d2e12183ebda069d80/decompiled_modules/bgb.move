module 0xfba53f15f35bf6b4948f33b6f32c9ade13596884f8c579d2e12183ebda069d80::bgb {
    struct BGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGB>(arg0, 9, b"BGB", b"Bgb token", b"BGB is meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90fc844c-5a57-41dc-bb62-bd99133b6240.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

