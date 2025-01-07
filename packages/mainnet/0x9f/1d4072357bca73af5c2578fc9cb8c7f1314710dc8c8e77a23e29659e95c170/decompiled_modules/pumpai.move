module 0x9f1d4072357bca73af5c2578fc9cb8c7f1314710dc8c8e77a23e29659e95c170::pumpai {
    struct PUMPAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PUMPAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMPAI>>(0x2::coin::mint<PUMPAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PUMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPAI>(arg0, 6, b"PUMPAI", b"PumpAI", b"The unofficial AI version of Pump.fun, the future of Sui Token Deployments", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FQm_Yn6th_J39_BFBA_3vtr_C1n_Cge8_Xqarq_F2_Caf9p_N_Cq_Eh_H8hy_d62ca1f4e3.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMPAI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMPAI>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

