module 0x5b58780c5e7cacf0df158154051754c956ec4cbc3cbc8a9483d8df22c9aa02e3::ltc {
    struct LTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTC>(arg0, 9, b"LTC", b"Lettuce", b"Lettuce are not fun are they?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7dc7f46c-919c-45c0-9b00-18e535ec7d76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

