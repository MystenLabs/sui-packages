module 0xc61fdb8205da702b90e73585494ce6ba98a4d79169278c766b1cc7d00ece1764::coffeee {
    struct COFFEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFEEE>(arg0, 9, b"COFFEEE", b"Coffee", b"Thebest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6baba45e-e3f0-4712-954f-199872ddfad7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COFFEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

