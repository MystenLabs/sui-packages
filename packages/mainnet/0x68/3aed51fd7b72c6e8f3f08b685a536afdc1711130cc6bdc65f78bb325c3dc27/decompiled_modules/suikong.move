module 0x683aed51fd7b72c6e8f3f08b685a536afdc1711130cc6bdc65f78bb325c3dc27::suikong {
    struct SUIKONG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIKONG>, arg1: 0x2::coin::Coin<SUIKONG>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIKONG>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIKONG>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUIKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKONG>(arg0, 6, b"Sui Kong", b"KONG", b"Kong is a Sui coin based on the narrative of the gorilla Kong from one of the greatest films of recent years.  https://x.com/suikong_dev   https://t.me/suikongportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmVEESPVVgNSBHjqnpR3HXHSnaARmrnTMpvCvZqiLuNPHS")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIKONG>, arg1: 0x2::coin::Coin<SUIKONG>) : u64 {
        0x2::coin::burn<SUIKONG>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIKONG>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIKONG> {
        0x2::coin::mint<SUIKONG>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

