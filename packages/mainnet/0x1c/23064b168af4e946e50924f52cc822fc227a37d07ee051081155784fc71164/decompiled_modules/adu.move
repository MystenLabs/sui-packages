module 0x1c23064b168af4e946e50924f52cc822fc227a37d07ee051081155784fc71164::adu {
    struct ADU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ADU>, arg1: 0x2::coin::Coin<ADU>) {
        0x2::coin::burn<ADU>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ADU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<ADU>(arg0) + arg1 <= 500000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<ADU>>(0x2::coin::mint<ADU>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<ADU>) : u64 {
        0x2::coin::total_supply<ADU>(arg0)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<ADU>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ADU>>(arg0, arg1);
    }

    fun init(arg0: ADU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADU>(arg0, 9, b"ADU", b"A Duck", b"A fair, mineable, and accessible token for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://duckcoin.space/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

