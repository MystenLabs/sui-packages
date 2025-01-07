module 0xd5394a7d89863d156fc8357d9abdf27f975a3830bf229450dc89aa1da6f8a08::monkeycto {
    struct MONKEYCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEYCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEYCTO>(arg0, 6, b"MONKEYCTO", b"CTO SUI MONKEY", b"I CLAIM THIS MEME, IMO IS A GOOD MEME, I TRY TO BOND THIS SHIT, ANY HELP IS WELCOME! PLEASE ENTER ON THE TELEGRAM TO HELP PUSH IT! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_12_222059_f0bc532770.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEYCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEYCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

