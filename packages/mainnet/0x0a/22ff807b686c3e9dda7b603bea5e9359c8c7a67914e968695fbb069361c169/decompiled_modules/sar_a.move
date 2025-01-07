module 0xa22ff807b686c3e9dda7b603bea5e9359c8c7a67914e968695fbb069361c169::sar_a {
    struct SAR_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAR_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAR_A>(arg0, 9, b"SAR_A", b"SaraValles", b"meme coin for sara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4cb09680-fb3f-45a1-b83b-ea2ff95a4222.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAR_A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAR_A>>(v1);
    }

    // decompiled from Move bytecode v6
}

