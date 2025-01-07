module 0x133a1cf68f3c6d03bbbed2b0945657291e796a029734c44df3c1173f2bab9a0::sealdoge {
    struct SEALDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALDOGE>(arg0, 6, b"SEALDOGE", b"SEAL DOGE", b"Seal \"D.O.G.E.\" was once an ordinary seal, splashing in the waters near a naval base, until one day, a classified experiment went hilariously right. A team of scientists, frustrated by endless government inefficiencies, decided to train the smartest seal in the world to help streamline bureaucratic chaos. Equipped with a tactical vest, a navy cap sporting the \"D.O.G.E.\" (Defender of Operational Government Efficiency) logo, and unmatched cuteness, Seal D.O.G.E. was born.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Navy_Seal_6e8d150a12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

