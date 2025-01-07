module 0xff441a0cff590a499bffbdcf79cb989deed5e21bc11fd33bcdf884a7bf883bb9::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLY>(arg0, 9, b"BULLY", b"BULLY", b"Bully Coin is a digital currency based on blockchain technology SUI. that strives to create a friendly and supportive community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pin.it/6zdVnbH")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULLY>(&mut v2, 777000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

