module 0x408438adac0cbe034e393be3e806b1b75c348eef2c2fc6fdebd888866d052417::oister {
    struct OISTER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OISTER>, arg1: 0x2::coin::Coin<OISTER>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OISTER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OISTER>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: OISTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OISTER>(arg0, 6, b"OISTER", b"Oister", b"WEBSITE https://www.oister.tech/ TWITTER https://x.com/oister_ape TELEGRAM https://t.me/oister_apes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmRAGseUs3NfmaqJ98WKw8CU2zbqpiGEV7ixWk8ezrpCKB")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OISTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OISTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<OISTER>, arg1: 0x2::coin::Coin<OISTER>) : u64 {
        0x2::coin::burn<OISTER>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<OISTER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<OISTER> {
        0x2::coin::mint<OISTER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

