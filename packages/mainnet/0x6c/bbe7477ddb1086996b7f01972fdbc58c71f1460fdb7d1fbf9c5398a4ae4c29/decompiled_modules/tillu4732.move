module 0x6cbbe7477ddb1086996b7f01972fdbc58c71f1460fdb7d1fbf9c5398a4ae4c29::tillu4732 {
    struct TILLU4732 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TILLU4732, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TILLU4732>(arg0, 9, b"TILLU4732", b"Dj", b"Going to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fecf2af3-be59-4a41-96e1-bd04324fa410.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TILLU4732>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TILLU4732>>(v1);
    }

    // decompiled from Move bytecode v6
}

