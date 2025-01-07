module 0x10729e11f6f33afcc6caab9a3cb253ce76a414df2d2dfa00bdad94168170ca22::muni {
    struct MUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNI>(arg0, 9, b"MUNI", b"Muning", b"Muning is a vibrant community hub on the Sui network, fostering meaningful connections and collaborations. We bridge innovators, creators, and enthusiasts, providing a platform ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32a1c590-6159-40bb-a9b9-3a94d4339c30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

