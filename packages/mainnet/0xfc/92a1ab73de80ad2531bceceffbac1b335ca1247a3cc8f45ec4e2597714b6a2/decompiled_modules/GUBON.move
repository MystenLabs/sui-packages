module 0xfc92a1ab73de80ad2531bceceffbac1b335ca1247a3cc8f45ec4e2597714b6a2::GUBON {
    struct GUBON has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUBON>, arg1: 0x2::coin::Coin<GUBON>) {
        0x2::coin::burn<GUBON>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUBON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUBON>(arg0, arg1, arg2, arg3);
    }

    entry fun burn_entry(arg0: &mut 0x2::coin::TreasuryCap<GUBON>, arg1: 0x2::coin::Coin<GUBON>, arg2: &mut 0x2::tx_context::TxContext) {
        burn(arg0, arg1);
    }

    fun init(arg0: GUBON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUBON>(arg0, 9, b"GUBON", b"GUBON", b"I AM GUBON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmfF9erhWqxTqrMjeX5w9NtqqLdh7bkKxeBFKGSHDeNudY")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUBON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GUBON>>(0x2::coin::mint<GUBON>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUBON>>(v2, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_entry(arg0: &mut 0x2::coin::TreasuryCap<GUBON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

