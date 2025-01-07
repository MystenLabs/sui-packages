module 0xe2f0fcc641e19c56ae7feba5e98984446fc14c500dd3b7d9ae8e11f066f0de51::rathva {
    struct RATHVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATHVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATHVA>(arg0, 9, b"RATHVA", b"Mongo", b"Muje Aacha laga ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82526142-9877-4f20-9779-103276abb361.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATHVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATHVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

