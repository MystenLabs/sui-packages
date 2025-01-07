module 0x98d231882f7e155832e539ae928aa6aedbe1213136d514200d6178fb54e9d60a::suishiba {
    struct SUISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIBA>(arg0, 9, b"Shiba Inu", b"Shiba Inu", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmXXGy1YKZqts4Zhgy4FiBEMpZGisEPnkv7nmKWT54QhTT"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_me(arg0: &mut 0x2::coin::TreasuryCap<SUISHIBA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIBA>>(0x2::coin::mint<SUISHIBA>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

