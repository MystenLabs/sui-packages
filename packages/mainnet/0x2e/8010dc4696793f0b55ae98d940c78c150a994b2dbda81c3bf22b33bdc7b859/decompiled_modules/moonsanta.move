module 0x2e8010dc4696793f0b55ae98d940c78c150a994b2dbda81c3bf22b33bdc7b859::moonsanta {
    struct MOONSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONSANTA>(arg0, 9, b"MoonSanta", b"Sui Moon Santa", b"Sui Moon Santa Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-vector/cute-santa-claus-singing-moon-cartoon-mascot-character_357749-1594.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOONSANTA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONSANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONSANTA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

