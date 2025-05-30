module 0xf7dc792e21cd225a7dae8fb92ebff241d997902c53faaea5cc566e532e8ee01c::cryptopig {
    struct CRYPTOPIG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CRYPTOPIG>, arg1: 0x2::coin::Coin<CRYPTOPIG>) {
        0x2::coin::burn<CRYPTOPIG>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CRYPTOPIG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CRYPTOPIG>>(0x2::coin::mint<CRYPTOPIG>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<CRYPTOPIG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CRYPTOPIG>>(0x2::coin::split<CRYPTOPIG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CRYPTOPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTOPIG>(arg0, 9, trim_right(b"cryptopig"), trim_right(b"cryptopig "), trim_right(x"e4b880e58faae58fafe788b1e79a84e5b08fe78caa"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreid745fqc6huwmbyvzqsnvyih4sdvygflgcupjkvzrrkb7tsf7fiw4"))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CRYPTOPIG>>(0x2::coin::mint<CRYPTOPIG>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTOPIG>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRYPTOPIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<CRYPTOPIG>, arg1: 0x2::coin::Coin<CRYPTOPIG>) {
        0x2::coin::join<CRYPTOPIG>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<CRYPTOPIG>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CRYPTOPIG>>(0x2::coin::mint<CRYPTOPIG>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

