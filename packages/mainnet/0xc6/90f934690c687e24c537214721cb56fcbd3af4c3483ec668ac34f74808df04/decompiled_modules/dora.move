module 0xc690f934690c687e24c537214721cb56fcbd3af4c3483ec668ac34f74808df04::dora {
    struct DORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORA>(arg0, 9, b"DORA", b"Doraemon", b"Doraemon on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2ff3f9a-a533-400b-b2d1-a0bc0f8bce80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

