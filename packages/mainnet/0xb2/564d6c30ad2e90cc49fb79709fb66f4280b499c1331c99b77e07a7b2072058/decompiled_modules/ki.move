module 0xb2564d6c30ad2e90cc49fb79709fb66f4280b499c1331c99b77e07a7b2072058::ki {
    struct KI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KI>(arg0, 9, b"KI", b"Kai", b"The legend goes on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82af4591-5259-4793-ad46-a651d64d5cd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KI>>(v1);
    }

    // decompiled from Move bytecode v6
}

