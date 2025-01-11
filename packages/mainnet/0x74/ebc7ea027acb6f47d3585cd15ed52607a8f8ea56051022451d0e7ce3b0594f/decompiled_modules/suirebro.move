module 0x74ebc7ea027acb6f47d3585cd15ed52607a8f8ea56051022451d0e7ce3b0594f::suirebro {
    struct SUIREBRO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIREBRO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIREBRO>>(0x2::coin::mint<SUIREBRO>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIREBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREBRO>(arg0, 9, b"suirebro", b"SUIREBRO", b"SUIREBRO, Ai Agent with zerebro framework first of kind on the sui blockchain fully autonomous capable of searching enormous data and extracting the alpha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1650588724000858112/6K1SFIW5_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIREBRO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIREBRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREBRO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

