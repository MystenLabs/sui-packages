module 0x2aff54e83720a5535fefc94022311ecb677213ea31a29ce83688ad18e15e00f4::pingy {
    struct PINGY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PINGY>, arg1: 0x2::coin::Coin<PINGY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PINGY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PINGY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: PINGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGY>(arg0, 6, b"PINGY", b"Pingy SUI", b"Welcome to the frosty yet surprisingly heartwarming world of $PINGY WEBSITE https://www.pingy.fun/ TWITTER https://x.com/Pingysui TELEGRAM https://t.me/pingysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUMhSrodnY3YvLVuZ5HBEHMH3koxyjVhM7i5PZzbcLzGM")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<PINGY>, arg1: 0x2::coin::Coin<PINGY>) : u64 {
        0x2::coin::burn<PINGY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<PINGY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PINGY> {
        0x2::coin::mint<PINGY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

