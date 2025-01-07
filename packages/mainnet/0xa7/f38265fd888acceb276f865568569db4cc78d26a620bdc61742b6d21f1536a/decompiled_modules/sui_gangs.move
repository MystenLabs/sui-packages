module 0xa7f38265fd888acceb276f865568569db4cc78d26a620bdc61742b6d21f1536a::sui_gangs {
    struct SUI_GANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_GANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_GANGS>(arg0, 9, b"Sui Gangs", b"Sui Gangs", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_GANGS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_GANGS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_GANGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

