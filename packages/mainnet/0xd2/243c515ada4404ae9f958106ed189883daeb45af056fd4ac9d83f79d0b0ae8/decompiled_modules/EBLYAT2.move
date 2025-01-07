module 0xd2243c515ada4404ae9f958106ed189883daeb45af056fd4ac9d83f79d0b0ae8::EBLYAT2 {
    struct EBLYAT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBLYAT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBLYAT2>(arg0, 9, b"EBLYAT2", b"EBLYAT2", b"EBLYAT2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmNyH48QYsfGP5uX4QCfiqWFfjvScBVnfnRi7T5cRsK8ti")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EBLYAT2>>(v1);
        0x2::coin::mint_and_transfer<EBLYAT2>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBLYAT2>>(v2, @0x0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EBLYAT2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    // decompiled from Move bytecode v6
}

