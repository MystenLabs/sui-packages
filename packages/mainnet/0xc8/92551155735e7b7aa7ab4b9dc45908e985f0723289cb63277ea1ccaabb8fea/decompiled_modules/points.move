module 0xc892551155735e7b7aa7ab4b9dc45908e985f0723289cb63277ea1ccaabb8fea::points {
    struct POINTS has drop {
        dummy_field: bool,
    }

    public fun burn_points(arg0: &mut 0x2::coin::TreasuryCap<POINTS>, arg1: 0x2::coin::Coin<POINTS>) {
        0x2::coin::burn<POINTS>(arg0, arg1);
    }

    fun init(arg0: POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POINTS>(arg0, 0, b"POINTS", b"CROCODILE PROTOCOL POINTS", b"crocodile protocol points token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cro-ag.pages.dev/points.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POINTS>>(v1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<POINTS>>(0x2::coin::mint<POINTS>(&mut v2, 10000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POINTS>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint_points(arg0: &mut 0x2::coin::TreasuryCap<POINTS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POINTS> {
        0x2::coin::mint<POINTS>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

