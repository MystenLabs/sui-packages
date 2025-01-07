module 0x7396a3a3c815f07c306f88d54506b3d91d32097632cbcc647583e82e28e1375e::hny {
    struct HNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNY>(arg0, 9, b"HNY", b"HONEY", b"A sweet cryptocurrency for buzzing communities...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6dfd2df-8ee6-4a00-be17-084d8e81fc35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

