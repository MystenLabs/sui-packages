module 0x2088bab8be5b8e80999397aa13b3ac5b9c5fb302530756b31d330936af8dcfb7::dha {
    struct DHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHA>(arg0, 9, b"DHA", b"Dhara", b"Probably everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/adfb5e82-f1e2-490c-9f45-a6c4e8159567.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

