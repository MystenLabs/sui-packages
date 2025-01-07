module 0x1b16b0e4d33cdd604526e3dfef57320ad6c4ae014a65ca7296917469f2b8542d::common_coin {
    struct COMMON_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COMMON_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COMMON_COIN>>(0x2::coin::mint<COMMON_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COMMON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMON_COIN>(arg0, 6, b"SUIGAR", b"Suigar", b"Suigar is a sweet, fresh & fun coin on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSUIGAR_PROFIL_b3088c58db.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMON_COIN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COMMON_COIN>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMON_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

