module 0xd600c29da045558a1197ff7fd4a6aef2c0a3caad9a3eb6dfbfba6769e2c341fa::thndrblts {
    struct THNDRBLTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THNDRBLTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THNDRBLTS>(arg0, 9, b"THNDRBLTS", b"Thunderbolts", b"After finding themselves ensnared in a death trap, an unconventional team of antiheroes must embark on a dangerous mission that will force them to confront the darkest corners of their pasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/THNDRBLTS.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THNDRBLTS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THNDRBLTS>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THNDRBLTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

