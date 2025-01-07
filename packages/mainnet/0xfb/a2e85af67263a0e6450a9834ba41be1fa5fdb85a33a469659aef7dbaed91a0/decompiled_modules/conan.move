module 0xfba2e85af67263a0e6450a9834ba41be1fa5fdb85a33a469659aef7dbaed91a0::conan {
    struct CONAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CONAN>, arg1: 0x2::coin::Coin<CONAN>) {
        0x2::coin::burn<CONAN>(arg0, arg1);
    }

    fun init(arg0: CONAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CONAN>(arg0, 9, b"CONAN", b"Justice for Conan", b"Conan the Dog is fighting for his life in the California legal system after being accused of a crime for defending his owner. His final appeal against a devastating euthanasia sentence is set for Monday, December 2, 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/D135ctX8k6ZnoSG1jXttLk6oVasBjuZT9QG2Cxbkpump.png?size=xl&key=c95c48")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CONAN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONAN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CONAN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CONAN>>(v1, @0xa128d142428919fbc347ed22ac6afe9e062ecdaaf985b115d470f390f49d6d25);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CONAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CONAN>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CONAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CONAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

