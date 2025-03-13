module 0xf6a6412df11009d23d7c73ef74206002a4915a71737658319e21da16b1ba0945::sry {
    struct SRY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SRY>(arg0) + arg1 <= 290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SRY>>(0x2::coin::mint<SRY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRY>(arg0, 6, b"SRY", b"SRY", b"SRY Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SRY>>(0x2::coin::mint<SRY>(&mut v2, 290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

