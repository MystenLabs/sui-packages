module 0xff40f3b8cca3c9e6122bb75aa5d8ca95b5eb27312f7c24d91305e11fa6890e4::pikachu {
    struct PIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKACHU>(arg0, 9, b"PIKACHU", b"WAVE", b"You inspire. It's better to try than to watch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffa4f831-3a09-446b-9eb6-76bf9a7a2f2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKACHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

