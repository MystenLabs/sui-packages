module 0xb80ec7e8d8389628a7f59055f339f6e216ed58bd8fbae6545d39fd8d22607bbd::peemee {
    struct PEEMEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEMEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEMEE>(arg0, 9, b"PEEMEE", b"Peeme ", b"Car say mee ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05d16571-2055-4a59-a2f1-ac83408735de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEMEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEEMEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

