module 0x4e803530b5a56ec969527a8f77e68f89e4c41907638585d6970b34f028b931d2::DRINYA {
    struct DRINYA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRINYA>, arg1: 0x2::coin::Coin<DRINYA>) {
        0x2::coin::burn<DRINYA>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRINYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRINYA>(arg0, arg1, arg2, arg3);
    }

    entry fun burn_entry(arg0: &mut 0x2::coin::TreasuryCap<DRINYA>, arg1: 0x2::coin::Coin<DRINYA>, arg2: &mut 0x2::tx_context::TxContext) {
        burn(arg0, arg1);
    }

    fun init(arg0: DRINYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRINYA>(arg0, 9, b"DRINYA", b"DRINYA", b"DRINYADRINYADRINYADRINYA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmY8oLfuXAzE9c1LKgaFAEsVNaektL4W82pLRDX4ChY1KZ")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRINYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DRINYA>>(0x2::coin::mint<DRINYA>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRINYA>>(v2, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_entry(arg0: &mut 0x2::coin::TreasuryCap<DRINYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

