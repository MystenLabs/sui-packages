module 0x6b64f8a44dfaa484ff09124c2fcce8442565086793a68f3ba45a0f0eb2c1bf06::t2p {
    struct T2P has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<T2P>, arg1: 0x2::coin::Coin<T2P>) {
        0x2::coin::burn<T2P>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<T2P>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T2P>>(0x2::coin::mint<T2P>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: T2P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T2P>(arg0, 9, b"T2P", b"TEXT2PAY", b"EASILY TEXT TO PAY YOUR FRIENDS OR BUSINESS PARTNERS FOR PROPERTY WITH TOKENS/COINS USING SLUSH WALLET OR OTHER WALLETS THAT ACCEPT SUI COIN PAIRS. SIMPLY MAKE A CLAIMABLE SLUSH LINK AND SEND AWAY! IF YOU NEED TO UNSEND AND THE SENDER HAS NOT TAKEN THE COINS YET, YOU CAN UNSEND THE COINS. WE/I AM NOT RESPONSIBLE FOR LOST FUNDS FOR ANY REASON. GOOD LUCK WITH THIS, AND HAVE FUN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifutbr5iebohuvdzrjex3rel7o55z3pireet4dzengqgyb3xkq4m4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T2P>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2P>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_fixed_supply(arg0: &mut 0x2::coin::TreasuryCap<T2P>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        mint(arg0, 1000000000000000000, v0, arg1);
    }

    // decompiled from Move bytecode v7
}

