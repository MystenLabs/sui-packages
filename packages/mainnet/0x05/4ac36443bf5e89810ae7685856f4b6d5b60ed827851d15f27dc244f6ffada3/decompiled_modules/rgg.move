module 0x54ac36443bf5e89810ae7685856f4b6d5b60ed827851d15f27dc244f6ffada3::rgg {
    struct RGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGG>(arg0, 9, b"RGG", b"KFG", b"Oh well I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1ee9f02-3022-4b7c-8680-088b48e14bdf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

