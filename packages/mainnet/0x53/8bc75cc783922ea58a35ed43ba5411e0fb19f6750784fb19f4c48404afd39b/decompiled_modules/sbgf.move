module 0x538bc75cc783922ea58a35ed43ba5411e0fb19f6750784fb19f4c48404afd39b::sbgf {
    struct SBGF has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SBGF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SBGF>(arg0) + arg1 <= 290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SBGF>>(0x2::coin::mint<SBGF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SBGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBGF>(arg0, 6, b"SBGF", b"SBGF", b"SBGF Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/moverUSD.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SBGF>>(0x2::coin::mint<SBGF>(&mut v2, 290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBGF>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SBGF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

