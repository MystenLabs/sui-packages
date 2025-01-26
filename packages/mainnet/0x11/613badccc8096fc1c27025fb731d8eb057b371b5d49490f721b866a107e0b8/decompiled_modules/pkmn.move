module 0x11613badccc8096fc1c27025fb731d8eb057b371b5d49490f721b866a107e0b8::pkmn {
    struct PKMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKMN>(arg0, 6, b"PKMN", b"Suicune", b"Suicune has a thick, purple mane that resembles the aurora borealis and two white, streamer-like tails that wave forward. It has a long, white snout.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737855870400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKMN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKMN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

