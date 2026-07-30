module 0xce3926fcc01b88d9b242f148ec840386c591c315be18c56915a02d96c3c7e039::global_digital_usd {
    struct GLOBAL_DIGITAL_USD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GLOBAL_DIGITAL_USD>, arg1: 0x2::coin::Coin<GLOBAL_DIGITAL_USD>) {
        0x2::coin::burn<GLOBAL_DIGITAL_USD>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GLOBAL_DIGITAL_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOBAL_DIGITAL_USD>>(0x2::coin::mint<GLOBAL_DIGITAL_USD>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<GLOBAL_DIGITAL_USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOBAL_DIGITAL_USD>>(0x2::coin::split<GLOBAL_DIGITAL_USD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GLOBAL_DIGITAL_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOBAL_DIGITAL_USD>(arg0, 9, trim_right(b"GUSD"), trim_right(b"Global Digital USD"), trim_right(x"476c6f62616c204469676974616c20446f6c6c617220284755534429206973206120636f6d706c69616e74205553442d6261636b656420737461626c65636f696e2064657369676e656420666f7220636f6e76656e69656e7420676c6f62616c207061796d656e747320616e6420656666696369656e7420736574746c656d656e742e204561636820746f6b656e206973207374726963746c79206261636b656420313a312062792061637475616c20555320646f6c6c61722061737365747320616e6420686967686c79206c69717569642063617368206571756976616c656e74732c20656e737572696e67206162736f6c7574652076616c75652073746162696c69747920616e64207472616e73706172656e63792e204279207365616d6c6573736c7920696e746567726174696e672074686520616476616e7461676573206f6620626c6f636b636861696e20746563686e6f6c6f6779e280947375636820617320646563656e7472616c697a6174696f6e2c207265616c2d74696d6520736574746c656d656e742c20616e64206c6f77207472616e73616374696f6e20636f737473e28094475553442061696d7320746f2070726f766964652061207365637572652c207365616d6c6573732c20616e642032342f3720676c6f62616c207061796d656e74206e6574776f726b20666f7220696e646976696475616c732c206d65726368616e74732c20616e6420696e737469747574696f6e616c2075736572732e"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.cpbox.io/ipfs/QmZgbiBAdhggvdNgrRiTty3jgnNh4APSff5eGiiMyZQk8m"))), arg1);
        let v2 = v0;
        if (1000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<GLOBAL_DIGITAL_USD>>(0x2::coin::mint<GLOBAL_DIGITAL_USD>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBAL_DIGITAL_USD>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLOBAL_DIGITAL_USD>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<GLOBAL_DIGITAL_USD>, arg1: 0x2::coin::Coin<GLOBAL_DIGITAL_USD>) {
        0x2::coin::join<GLOBAL_DIGITAL_USD>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<GLOBAL_DIGITAL_USD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOBAL_DIGITAL_USD>>(0x2::coin::mint<GLOBAL_DIGITAL_USD>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

