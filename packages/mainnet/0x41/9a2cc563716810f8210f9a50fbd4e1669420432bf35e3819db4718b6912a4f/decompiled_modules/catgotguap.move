module 0x419a2cc563716810f8210f9a50fbd4e1669420432bf35e3819db4718b6912a4f::catgotguap {
    struct CATGOTGUAP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATGOTGUAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CATGOTGUAP>>(0x2::coin::mint<CATGOTGUAP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CATGOTGUAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGOTGUAP>(arg0, 6, b"CATGOTGUAP", b"CATGOTGUAP", b"This is Catgotguap token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATGOTGUAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGOTGUAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

