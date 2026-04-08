module 0xe85200904cbdc914de4a060f3e37045588b1d88b62e801de5fc08e46dca84844::main_bb8 {
    struct MAIN_BB8 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<MAIN_BB8>, arg1: 0x2::coin::Coin<MAIN_BB8>) {
        0x2::coin::burn<MAIN_BB8>(arg0, arg1);
    }

    fun init(arg0: MAIN_BB8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAIN_BB8>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MAIN_BB8>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAIN_BB8>>(v1);
    }

    public fun produce(arg0: &mut 0x2::coin::TreasuryCap<MAIN_BB8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MAIN_BB8> {
        0x2::coin::mint<MAIN_BB8>(arg0, arg1, arg2)
    }

    public entry fun produce_to(arg0: &mut 0x2::coin::TreasuryCap<MAIN_BB8>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAIN_BB8>>(0x2::coin::mint<MAIN_BB8>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

