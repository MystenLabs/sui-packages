module 0xd65b294b1d8af1d617028fcbcd9b543b7efa3c236e913787f4267842361dbf31::soo {
    struct SOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOO>(arg0, 9, b"SOO", b"SOO", b"Soo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yankeedabbler.com/cdn/shop/files/soo_6603_roster_1_weba_869a6236-19b3-4dc2-9240-0e3915e04bc9.jpg?v=1713018820&width=1214")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

