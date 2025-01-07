module 0xa0207d5bc968b7c5daf4252e92efbbc91b7148044f714123b80f9a53d5b637f5::sdk {
    struct SDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDK>(arg0, 9, b"SDK", b"Sidik", b"Kebenaran", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91ec7788-1da9-4e03-8e23-a1420b378752.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

