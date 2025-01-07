module 0xbc9977762f829768e2c19921cca41ed77455dd4fa06c006bce1cd3aa4c2f2c09::DOTUSS {
    struct DOTUSS has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<DOTUSS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOTUSS>>(arg0, arg1);
    }

    fun init(arg0: DOTUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTUSS>(arg0, 9, b"DOTUSS", b"DOGE CETUS", b"liquidity will be burn. join us @dogecetus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmQuFgSXCac4K2BgckEwLsix2pXU7i2mnPqeYiZ8V2UYjS?_gl=1*pw85y3*rs_ga*NGMxYTE0YzUtNjg3OS00MTMxLThhM2EtMGZiMjljNzQ2OWYz*rs_ga_5RMPXG14TE*MTY4MzcxMDMxMy40LjEuMTY4MzcxMDY0Mi42MC4wLjA.")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<DOTUSS>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTUSS>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOTUSS>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOTUSS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOTUSS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

