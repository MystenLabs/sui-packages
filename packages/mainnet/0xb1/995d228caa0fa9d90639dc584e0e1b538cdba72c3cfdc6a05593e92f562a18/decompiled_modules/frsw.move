module 0xb1995d228caa0fa9d90639dc584e0e1b538cdba72c3cfdc6a05593e92f562a18::frsw {
    struct FRSW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRSW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRSW>(arg0, 9, b"FRSW", b"ForrestWay", b"Forrest Way Is The Dreamy Way! Walk Trough It!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8da11487-d0f8-4269-ae3a-f934b9c2bcad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRSW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRSW>>(v1);
    }

    // decompiled from Move bytecode v6
}

