module 0xa193e2a7622c2a075ca78f8933847ed6c24368423450bb4b1f46dfb583ee0bc3::odk {
    struct ODK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODK>(arg0, 9, b"ODK", b"Otdel-K", b"Super ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b77606f-6d06-4f48-9f38-a6531995f3f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ODK>>(v1);
    }

    // decompiled from Move bytecode v6
}

