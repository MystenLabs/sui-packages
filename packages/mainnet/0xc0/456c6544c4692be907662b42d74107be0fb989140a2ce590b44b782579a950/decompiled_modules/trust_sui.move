module 0xc0456c6544c4692be907662b42d74107be0fb989140a2ce590b44b782579a950::trust_sui {
    struct TRUST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUST_SUI>(arg0, 6, b"TRUST", b"trust coin", b"The most valuable coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-tremendous-canidae-396.mypinata.cloud/ipfs/QmSNRiCLDCZ2RJFvn9mJ7gmWpm45pgNAZeJJ3wYEkaje5F")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUST_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUST_SUI>>(0x2::coin::mint<TRUST_SUI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUST_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

