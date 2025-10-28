module 0xd67205e6e498dc4d329625b86d9098d9534a7a504e719259a00c5a568ebccc38::sui_tr_xcion {
    struct SUI_TR_XCION has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_TR_XCION>, arg1: 0x2::coin::Coin<SUI_TR_XCION>) {
        0x2::coin::burn<SUI_TR_XCION>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_TR_XCION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_TR_XCION>>(0x2::coin::mint<SUI_TR_XCION>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<SUI_TR_XCION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_TR_XCION>>(0x2::coin::split<SUI_TR_XCION>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUI_TR_XCION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_TR_XCION>(arg0, 9, trim_right(b"TRX"), trim_right(b"SuiTRXcion"), trim_right(b"yulezhuanyong"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://ipfs.io/ipfs/bafkreicuohgyte2wue6ncu7qtm5ollj3tl24cipehglglao4dp6aginzum"))), arg1);
        let v2 = v0;
        if (1137382688000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUI_TR_XCION>>(0x2::coin::mint<SUI_TR_XCION>(&mut v2, 1137382688000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TR_XCION>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI_TR_XCION>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<SUI_TR_XCION>, arg1: 0x2::coin::Coin<SUI_TR_XCION>) {
        0x2::coin::join<SUI_TR_XCION>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<SUI_TR_XCION>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_TR_XCION>>(0x2::coin::mint<SUI_TR_XCION>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
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

