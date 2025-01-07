module 0x5202a110c76c70e99b46211381eef4821cb000937c55488ea339b60319bba97::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW>(arg0, 9, b"PAW", b"Paws", x"5061777320f09f90be20746f6b656e206f6e20776577652070726f6a65637420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fe70dac-1a27-4a62-91e2-49e1057fc6f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

