module 0xc50d04ed0b0840e9dea26fd6ebfb7ab79ceaa650f85dd3b8c92f2092978133d1::primary_aa6 {
    struct PRIMARY_AA6 has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_AA6>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY_AA6> {
        0x2::coin::mint<PRIMARY_AA6>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_AA6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY_AA6>>(0x2::coin::mint<PRIMARY_AA6>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_AA6>, arg1: 0x2::coin::Coin<PRIMARY_AA6>) {
        0x2::coin::burn<PRIMARY_AA6>(arg0, arg1);
    }

    fun init(arg0: PRIMARY_AA6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY_AA6>(arg0, 9, b"BUT", b"Bucket Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-DZctYy7jsM.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY_AA6>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY_AA6>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

