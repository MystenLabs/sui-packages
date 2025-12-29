module 0xd63565ed5f7c453ffa38ca7b7cf6ba6b6026ee167e2ca7b710a33412e8af2ef::tether_usd {
    struct TETHER_USD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TETHER_USD>, arg1: 0x2::coin::Coin<TETHER_USD>) {
        0x2::coin::burn<TETHER_USD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TETHER_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TETHER_USD>>(0x2::coin::mint<TETHER_USD>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<TETHER_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TETHER_USD>>(0x2::coin::split<TETHER_USD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TETHER_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETHER_USD>(arg0, 9, trim_right(b"USDT"), trim_right(b"Tether USD"), trim_right(b""), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreigeqajmhoy2enlsuhkcw2i6ppsdyzbexijw4u6irnqnix32kretbi"))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TETHER_USD>>(0x2::coin::mint<TETHER_USD>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETHER_USD>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TETHER_USD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<TETHER_USD>, arg1: 0x2::coin::Coin<TETHER_USD>) {
        0x2::coin::join<TETHER_USD>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<TETHER_USD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TETHER_USD>>(0x2::coin::mint<TETHER_USD>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

