module 0x48a68b9ae28406ab8c660f7e0adbe4c2c2554af610a345c50858514268b24075::mcqueen {
    struct MCQUEEN has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"MCQUEEN", b"SUI MCQUEEN LIGHTNING", b"KA CHOW SUI MCQUEEN IS COMING TO WIN THE RACE TO THE TOP, BUY HODL AND NEVER GIVE UP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gray-distinctive-walrus-769.mypinata.cloud/ipfs/QmdNGivkvRCLRUFV3HUAUModMfT2eq5ctehYcNaHn47K8e")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: MCQUEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<MCQUEEN>(arg0, arg1);
        0x2::coin::mint_and_transfer<MCQUEEN>(&mut v0, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCQUEEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

