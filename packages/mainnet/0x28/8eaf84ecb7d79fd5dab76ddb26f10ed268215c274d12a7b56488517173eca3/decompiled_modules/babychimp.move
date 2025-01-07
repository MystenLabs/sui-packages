module 0x288eaf84ecb7d79fd5dab76ddb26f10ed268215c274d12a7b56488517173eca3::babychimp {
    struct BABYCHIMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABYCHIMP>, arg1: 0x2::coin::Coin<BABYCHIMP>) {
        0x2::coin::burn<BABYCHIMP>(arg0, arg1);
    }

    fun init(arg0: BABYCHIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCHIMP>(arg0, 9, b"BABYCHIMP", b"BABYCHIMP", b"I love cleaning BABYCHIMP SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/45rpJUMN39M2QfjCJsas5iqmdF61ByD4Wmn6oSMTpump.png?size=lg&key=318365")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYCHIMP>>(v1);
        0x2::coin::mint_and_transfer<BABYCHIMP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BABYCHIMP>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYCHIMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABYCHIMP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

