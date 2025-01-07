module 0x68fd905fa66a96dbd8281a5230c57b463cab2f03b42dc0b098118dc7de384f2e::kan {
    struct KAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAN>(arg0, 9, b"KAN", b"Kandle", b"Hold to moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb351d48-6d7e-4726-880a-1df50efffae3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

