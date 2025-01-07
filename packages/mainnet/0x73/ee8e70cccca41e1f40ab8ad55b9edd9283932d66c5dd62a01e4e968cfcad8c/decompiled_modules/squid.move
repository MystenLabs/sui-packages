module 0x73ee8e70cccca41e1f40ab8ad55b9edd9283932d66c5dd62a01e4e968cfcad8c::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SQUID>, arg1: 0x2::coin::Coin<SQUID>) {
        0x2::coin::burn<SQUID>(arg0, arg1);
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 9, b"SQUID", b"Squid Game", b"Squid Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/13276.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQUID>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SQUID>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

