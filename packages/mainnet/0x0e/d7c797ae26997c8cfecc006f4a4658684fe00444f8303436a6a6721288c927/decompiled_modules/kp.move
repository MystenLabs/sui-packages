module 0xed7c797ae26997c8cfecc006f4a4658684fe00444f8303436a6a6721288c927::kp {
    struct KP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KP>(arg0, 9, b"KP", b"Kapa", b"Kapapa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e69931ca-c422-4016-8408-fe9899c51040.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KP>>(v1);
    }

    // decompiled from Move bytecode v6
}

