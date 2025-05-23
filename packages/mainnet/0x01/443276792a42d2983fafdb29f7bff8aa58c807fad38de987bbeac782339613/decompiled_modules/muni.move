module 0x1443276792a42d2983fafdb29f7bff8aa58c807fad38de987bbeac782339613::muni {
    struct MUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNI>(arg0, 9, b"MUNI", b"Muning", b"Muning is a vibrant community hub on the Sui network, fostering meaningful connections and collaborations. We bridge innovators, creators, and enthusiasts, providing a platform ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/480ae3b2-39b9-4fe7-a878-833d206f5306.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

