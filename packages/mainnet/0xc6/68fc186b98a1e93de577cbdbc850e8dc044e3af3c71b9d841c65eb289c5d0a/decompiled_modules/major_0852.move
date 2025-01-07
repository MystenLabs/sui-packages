module 0xc668fc186b98a1e93de577cbdbc850e8dc044e3af3c71b9d841c65eb289c5d0a::major_0852 {
    struct MAJOR_0852 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR_0852, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJOR_0852>(arg0, 9, b"MAJOR_0852", b"Dessy", b"A token to please my mom ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5323b89-dbca-403e-bb9b-e94e256cbe86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR_0852>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAJOR_0852>>(v1);
    }

    // decompiled from Move bytecode v6
}

