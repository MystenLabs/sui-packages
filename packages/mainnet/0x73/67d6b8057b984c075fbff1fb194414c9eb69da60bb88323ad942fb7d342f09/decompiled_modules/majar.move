module 0x7367d6b8057b984c075fbff1fb194414c9eb69da60bb88323ad942fb7d342f09::majar {
    struct MAJAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJAR>(arg0, 9, b"MAJAR", b"Majar star", b"Gold star meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/066ac5e1-df4f-4ee6-b96d-885274515eeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAJAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

