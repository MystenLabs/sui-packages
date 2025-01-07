module 0x4fe198e4b5b5e1613cbd33c69446d021cb8d85a933a27996d0efd77fc57f5455::smole {
    struct SMOLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SMOLE>, arg1: 0x2::coin::Coin<SMOLE>) {
        0x2::coin::burn<SMOLE>(arg0, arg1);
    }

    fun init(arg0: SMOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLE>(arg0, 4, b"SMOLE", b"SMOLE", b"Smole coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9Ttyez3xiruyj6cqaR495hbBkJU6SUWdV6AmQ9MvbyyS.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xd437be3eb32e137a6b287d114cb37f6be9a5412483c5913bf1734174e7fd46dd, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOLE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SMOLE>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<SMOLE>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SMOLE>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

