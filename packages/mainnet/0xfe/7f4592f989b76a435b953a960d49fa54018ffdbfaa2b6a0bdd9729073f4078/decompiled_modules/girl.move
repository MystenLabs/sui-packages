module 0xfe7f4592f989b76a435b953a960d49fa54018ffdbfaa2b6a0bdd9729073f4078::girl {
    struct GIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRL>(arg0, 9, b"GIRL", b"One girl", b"5 black guys and blonde", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4895e54-dc41-4660-8b62-d9907c02cde3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

