module 0x3d4d23d0d45ed86a7e3dcdef037b5fba7afc8f92298722fc8a35186b4956f645::sabq {
    struct SABQ has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SABQ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SABQ>(arg0) + arg1 <= 1290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SABQ>>(0x2::coin::mint<SABQ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SABQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABQ>(arg0, 6, b"SABQ", b"SABQ", b"SABQ Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SABQ>>(0x2::coin::mint<SABQ>(&mut v2, 1290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABQ>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SABQ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

