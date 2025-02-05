module 0x8895740442359d8ad1a4de2dd912d94e0597a46fcb17b321457ceb0c1e367459::free {
    struct FREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREE>(arg0, 9, b"FREE", b"FREE Token", b"Free Token for Sniping Demo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c338edc-3aed-4a33-99fa-ad76e9354b7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

