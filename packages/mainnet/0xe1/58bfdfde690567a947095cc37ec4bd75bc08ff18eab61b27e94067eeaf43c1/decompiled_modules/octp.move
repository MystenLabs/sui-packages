module 0xe158bfdfde690567a947095cc37ec4bd75bc08ff18eab61b27e94067eeaf43c1::octp {
    struct OCTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTP>(arg0, 9, b"OCTP", b"Octopus", b"The Octopus is a powerful symbol of high intelligence, transformation, regeneration and resourcefulness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c02a9a2-675f-4aab-935a-6441c405b1dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

