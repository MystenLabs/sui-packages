module 0x9630844185790f42d38ea408a884f1f1ad037802e9fb57b8910c1d42dadbaf49::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBY>(arg0, 6, b"KUI", b"Kirby Sui", b"Kirby is largely innocent and has a cheerful demeanor and a positive attitude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/0Nt2aXz.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRBY>>(v1);
        0x2::coin::mint_and_transfer<KIRBY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun reounceownership(arg0: 0x2::coin::TreasuryCap<KIRBY>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

