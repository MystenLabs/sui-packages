module 0x82663715dd183c7443d7dacd2b7ce6dacb0d61f868ac0bec648c1a31c1879112::pato88 {
    struct PATO88 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATO88, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATO88>(arg0, 9, b"PATO88", b"Pato", b"World lively cat designs for peace all over the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ada0ba25-12ff-44ac-90a1-3733452a3016.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATO88>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PATO88>>(v1);
    }

    // decompiled from Move bytecode v6
}

