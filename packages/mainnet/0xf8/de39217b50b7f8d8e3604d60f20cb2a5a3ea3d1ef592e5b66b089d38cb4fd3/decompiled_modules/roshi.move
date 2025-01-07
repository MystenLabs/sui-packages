module 0xf8de39217b50b7f8d8e3604d60f20cb2a5a3ea3d1ef592e5b66b089d38cb4fd3::roshi {
    struct ROSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSHI>(arg0, 6, b"ROSHI", b"Master Roshi", b"Master $Roshi, also known as the Turtle Hermit and the God of Martial Arts, is a master of martial arts who trained Gohan (Goku's adopted father), Ox-King, Goku, Krillin, and Yamcha. He has a sister named Fortuneteller Baba. He is a hermit and a pervert.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_02_34_56_873d3d14a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

