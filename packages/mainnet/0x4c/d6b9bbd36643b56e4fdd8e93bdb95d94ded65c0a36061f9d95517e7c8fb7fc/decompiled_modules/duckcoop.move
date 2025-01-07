module 0x4cd6b9bbd36643b56e4fdd8e93bdb95d94ded65c0a36061f9d95517e7c8fb7fc::duckcoop {
    struct DUCKCOOP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUCKCOOP>, arg1: 0x2::coin::Coin<DUCKCOOP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCKCOOP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUCKCOOP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DUCKCOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKCOOP>(arg0, 6, b"DUCK", b"Duck Coop", b"$DUCK   https://x.com/DuckCoop_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmZoVFNduPJvwnzyzmi8iztUw3dpiReGdiVKkUoxE9RKYL")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKCOOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKCOOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DUCKCOOP>, arg1: 0x2::coin::Coin<DUCKCOOP>) : u64 {
        0x2::coin::burn<DUCKCOOP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DUCKCOOP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DUCKCOOP> {
        0x2::coin::mint<DUCKCOOP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

