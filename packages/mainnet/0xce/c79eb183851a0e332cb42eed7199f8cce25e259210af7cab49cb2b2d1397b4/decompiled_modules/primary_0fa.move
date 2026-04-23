module 0xcec79eb183851a0e332cb42eed7199f8cce25e259210af7cab49cb2b2d1397b4::primary_0fa {
    struct PRIMARY_0FA has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_0FA>, arg1: 0x2::coin::Coin<PRIMARY_0FA>) {
        0x2::coin::burn<PRIMARY_0FA>(arg0, arg1);
    }

    fun init(arg0: PRIMARY_0FA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMARY_0FA>(arg0, 9, b"GSUI", b"Grayscale Staked Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-eeQZNDYpx5.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PRIMARY_0FA>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIMARY_0FA>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_0FA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PRIMARY_0FA> {
        0x2::coin::mint<PRIMARY_0FA>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<PRIMARY_0FA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMARY_0FA>>(0x2::coin::mint<PRIMARY_0FA>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

