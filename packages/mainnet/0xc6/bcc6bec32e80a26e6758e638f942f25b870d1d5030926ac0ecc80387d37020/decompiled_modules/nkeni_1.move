module 0xc6bcc6bec32e80a26e6758e638f942f25b870d1d5030926ac0ecc80387d37020::nkeni_1 {
    struct NKENI_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKENI_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKENI_1>(arg0, 9, b"NKENI_1", b"Phil ", b"Creating wealth for my love ones.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49230d6f-4422-4b14-abbd-c5d09b9092f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKENI_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKENI_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

