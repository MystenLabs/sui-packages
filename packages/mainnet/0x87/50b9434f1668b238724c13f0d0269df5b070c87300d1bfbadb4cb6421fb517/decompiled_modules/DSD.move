module 0x8750b9434f1668b238724c13f0d0269df5b070c87300d1bfbadb4cb6421fb517::DSD {
    struct DSD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DSD>, arg1: vector<0x2::coin::Coin<DSD>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<DSD>>(&mut arg1);
        0x2::pay::join_vec<DSD>(&mut v0, arg1);
        0x2::coin::burn<DSD>(arg0, 0x2::coin::split<DSD>(&mut v0, arg2, arg3));
        if (0x2::coin::value<DSD>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<DSD>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<DSD>(v0);
        };
    }

    fun init(arg0: DSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSD>(arg0, 9, b"DSD", b"DSD", b"DSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRbqmvgPfkKAvnv1Xh2gqHmJ3VFaJqHNHHjBYKkehmNoF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DSD>(&mut v2, 100000000000000000, @0x2b1500ea64ee033cc2ecbc90ac2b1665727088c929d4715a930fe1a398a3cf99, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSD>>(v2, @0x2b1500ea64ee033cc2ecbc90ac2b1665727088c929d4715a930fe1a398a3cf99);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DSD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

