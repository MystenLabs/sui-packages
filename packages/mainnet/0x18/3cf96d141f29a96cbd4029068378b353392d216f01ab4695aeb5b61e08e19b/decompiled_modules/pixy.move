module 0x183cf96d141f29a96cbd4029068378b353392d216f01ab4695aeb5b61e08e19b::pixy {
    struct PIXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXY>(arg0, 9, b"PIXY", b"Pixel girl", b"Pixel girl token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2839cfed-7d27-4a2a-a055-f2031d5d230a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

