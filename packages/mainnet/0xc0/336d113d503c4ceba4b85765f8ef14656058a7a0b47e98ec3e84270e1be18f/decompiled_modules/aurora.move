module 0xc0336d113d503c4ceba4b85765f8ef14656058a7a0b47e98ec3e84270e1be18f::aurora {
    struct AURORA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AURORA>, arg1: 0x2::coin::Coin<AURORA>) {
        0x2::coin::burn<AURORA>(arg0, arg1);
    }

    fun init(arg0: AURORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURORA>(arg0, 9, b"AURORA", b"AURORA", b"Aurora, awakens the stars, guiding souls through the veil of light and shadow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9tF4vuYRQY3d5GPnE9pjUevukgo6vHiepe3E1w8Jpump.png?size=lg&key=752f30")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AURORA>>(v1);
        0x2::coin::mint_and_transfer<AURORA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AURORA>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AURORA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AURORA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

