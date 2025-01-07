module 0x3c958df00fad4c13242d6ba76ff3e66707408e9e98215392d25c697978e43dbf::baradenza {
    struct BARADENZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARADENZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARADENZA>(arg0, 9, b"BARADENZA", b"BARADENZA Token", b"The official BARADENZA token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmX6niogLDLp2hQKa1wccnCYZ1WFzzjuihzKQmhqoxcqyW")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARADENZA>>(v1);
        let v3 = &mut v2;
        let v4 = mint_initial(v3, 1000000000, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BARADENZA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BARADENZA>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun mint_initial(arg0: &mut 0x2::coin::TreasuryCap<BARADENZA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BARADENZA> {
        0x2::coin::mint<BARADENZA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

