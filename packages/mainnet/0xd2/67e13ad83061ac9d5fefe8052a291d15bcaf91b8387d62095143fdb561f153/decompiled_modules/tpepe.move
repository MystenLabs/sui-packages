module 0xd267e13ad83061ac9d5fefe8052a291d15bcaf91b8387d62095143fdb561f153::tpepe {
    struct TPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPEPE>(arg0, 9, b"TPEPE", b"Turbo Pepe", b"Inspiration from the combination of turbo and pepe which is already world famous and very famous. save and we will be very big", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6055d20-3b7b-4bda-bdbb-5d064987241b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

