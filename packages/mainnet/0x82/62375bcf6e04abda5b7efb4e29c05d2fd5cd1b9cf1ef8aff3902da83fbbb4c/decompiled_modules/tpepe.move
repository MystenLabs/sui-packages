module 0x8262375bcf6e04abda5b7efb4e29c05d2fd5cd1b9cf1ef8aff3902da83fbbb4c::tpepe {
    struct TPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPEPE>(arg0, 9, b"TPEPE", b"Turbo Pepe", b"Inspiration from the combination of turbo and pepe which is already world famous and very famous. save and we will be big. believe me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51b6c727-f06d-4ca6-8746-e71063b5e5c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

