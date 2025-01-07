module 0x87f2fa4ddaf323de039c23fc3ed1ddd84d4db8744c71fadcec15b2959ddded45::munmun {
    struct MUNMUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNMUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNMUN>(arg0, 9, b"MUNMUN", b"Mun", b"Only M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2c22f32-0430-4e65-a365-5ee62efabd17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNMUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNMUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

