module 0x8f78226e5111e778a9b170b23a753a3fb227a91221df897c2e1aefc3eeabb6e2::Suimi {
    struct SUIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMI>(arg0, 6, b"Suimi", b"SUIMI", b"Suimi is an Axolotl living in the Sui Ocean, she is described as the most beautiful creature of the Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/M66RDhm/Design-sans-titre-png.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

