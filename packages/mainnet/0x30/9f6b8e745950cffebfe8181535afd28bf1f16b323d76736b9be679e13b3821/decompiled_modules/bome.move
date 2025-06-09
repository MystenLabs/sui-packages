module 0x309f6b8e745950cffebfe8181535afd28bf1f16b323d76736b9be679e13b3821::bome {
    struct BOME has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOME>>(0x2::coin::mint<BOME>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME>(arg0, 9, b"BOME", b"BOME", b"BOME is the community token for the French-speaking Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/N0fHSjsp/bome.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

