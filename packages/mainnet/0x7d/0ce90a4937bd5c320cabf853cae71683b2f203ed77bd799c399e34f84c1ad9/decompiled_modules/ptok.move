module 0x7d0ce90a4937bd5c320cabf853cae71683b2f203ed77bd799c399e34f84c1ad9::ptok {
    struct PTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTOK>(arg0, 9, b"PTOK", b"Performing Token", b"Performing Token This", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PTOK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

