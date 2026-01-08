module 0x606032eae631c552e0fc18b4fd4c4a501d5de47fb2a573a3d0fb6e1b6f34f802::luffy_gear_five {
    struct LUFFY_GEAR_FIVE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LUFFY_GEAR_FIVE>, arg1: 0x2::coin::Coin<LUFFY_GEAR_FIVE>) {
        0x2::coin::burn<LUFFY_GEAR_FIVE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUFFY_GEAR_FIVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUFFY_GEAR_FIVE>>(0x2::coin::mint<LUFFY_GEAR_FIVE>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<LUFFY_GEAR_FIVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUFFY_GEAR_FIVE>>(0x2::coin::split<LUFFY_GEAR_FIVE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LUFFY_GEAR_FIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY_GEAR_FIVE>(arg0, 9, trim_right(b"G5"), trim_right(b"Luffy Gear Five"), trim_right(b"Luffy Gear Five Token"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreigrnchsrtarhikp3tduy3zuhkdf6wuwjtunddfkvfefco37epxxtq"))), arg1);
        let v2 = v0;
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<LUFFY_GEAR_FIVE>>(0x2::coin::mint<LUFFY_GEAR_FIVE>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY_GEAR_FIVE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUFFY_GEAR_FIVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<LUFFY_GEAR_FIVE>, arg1: 0x2::coin::Coin<LUFFY_GEAR_FIVE>) {
        0x2::coin::join<LUFFY_GEAR_FIVE>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<LUFFY_GEAR_FIVE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUFFY_GEAR_FIVE>>(0x2::coin::mint<LUFFY_GEAR_FIVE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

