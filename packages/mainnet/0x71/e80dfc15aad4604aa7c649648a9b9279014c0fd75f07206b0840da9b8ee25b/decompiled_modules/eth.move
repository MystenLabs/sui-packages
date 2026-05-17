module 0x71e80dfc15aad4604aa7c649648a9b9279014c0fd75f07206b0840da9b8ee25b::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ETH>, arg1: 0x2::coin::Coin<ETH>) {
        0x2::coin::burn<ETH>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ETH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ETH>>(0x2::coin::mint<ETH>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<ETH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ETH>>(0x2::coin::split<ETH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 9, trim_right(b"ETH"), trim_right(b"ETH "), trim_right(b"Ethereum"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.cpbox.io/ipfs/QmarisdzxCCvSoeH32bXGs4aMpEr4TZuvwPn6LKtuD17SE"))), arg1);
        let v2 = v0;
        if (77000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ETH>>(0x2::coin::mint<ETH>(&mut v2, 77000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ETH>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<ETH>, arg1: 0x2::coin::Coin<ETH>) {
        0x2::coin::join<ETH>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<ETH>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ETH>>(0x2::coin::mint<ETH>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (*0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != 32) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

