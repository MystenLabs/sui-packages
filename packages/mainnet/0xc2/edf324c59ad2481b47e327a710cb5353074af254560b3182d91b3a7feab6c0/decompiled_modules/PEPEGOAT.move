module 0xc2edf324c59ad2481b47e327a710cb5353074af254560b3182d91b3a7feab6c0::PEPEGOAT {
    struct PEPEGOAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPEGOAT>, arg1: vector<0x2::coin::Coin<PEPEGOAT>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<PEPEGOAT>>(&mut arg1);
        0x2::pay::join_vec<PEPEGOAT>(&mut v0, arg1);
        0x2::coin::burn<PEPEGOAT>(arg0, 0x2::coin::split<PEPEGOAT>(&mut v0, arg2, arg3));
        if (0x2::coin::value<PEPEGOAT>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<PEPEGOAT>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<PEPEGOAT>(v0);
        };
    }

    fun init(arg0: PEPEGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEGOAT>(arg0, 6, b"PepeGOAT", b"pepeGOAT", b"PepeGOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXGaEc2XPKZetBesrZrDUfYF6UgQ7VRk8wuCVCobDt6wg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPEGOAT>(&mut v2, 10000000000000000000, @0x3ee2358582545960e6609a2817e9cf2b612da0f50d8b88edd9417a182de1b1f4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEGOAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEGOAT>>(v2, @0x3ee2358582545960e6609a2817e9cf2b612da0f50d8b88edd9417a182de1b1f4);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEGOAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPEGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

