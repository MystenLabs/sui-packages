module 0xefe348da4bee12ecc9ea08bf7ce785bd1ce3d5893426dd11b2a397b3345bc7d3::SDOP {
    struct SDOP has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SDOP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SDOP>(arg0) + arg1 <= 10000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOP>>(0x2::coin::mint<SDOP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SDOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOP>(arg0, 6, b"SDOP", b"SDOP", b"SDOP Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/thumbs/saber.png?v=040")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SDOP>>(0x2::coin::mint<SDOP>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

