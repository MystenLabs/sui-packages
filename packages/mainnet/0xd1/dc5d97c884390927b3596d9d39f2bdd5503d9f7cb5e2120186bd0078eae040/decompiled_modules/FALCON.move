module 0xd1dc5d97c884390927b3596d9d39f2bdd5503d9f7cb5e2120186bd0078eae040::FALCON {
    struct FALCON has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FALCON>, arg1: 0x2::coin::Coin<FALCON>) {
        0x2::coin::burn<FALCON>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FALCON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FALCON>(arg0, arg1, arg2, arg3);
    }

    entry fun burn_entry(arg0: &mut 0x2::coin::TreasuryCap<FALCON>, arg1: 0x2::coin::Coin<FALCON>, arg2: &mut 0x2::tx_context::TxContext) {
        burn(arg0, arg1);
    }

    fun init(arg0: FALCON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALCON>(arg0, 9, b"FALCON", b"FALCON", b"I AM FALCON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmfF9erhWqxTqrMjeX5w9NtqqLdh7bkKxeBFKGSHDeNudY")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FALCON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FALCON>>(0x2::coin::mint<FALCON>(&mut v2, 10000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALCON>>(v2, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_entry(arg0: &mut 0x2::coin::TreasuryCap<FALCON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

