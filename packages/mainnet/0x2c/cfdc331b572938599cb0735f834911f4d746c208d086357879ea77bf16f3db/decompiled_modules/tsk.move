module 0x2ccfdc331b572938599cb0735f834911f4d746c208d086357879ea77bf16f3db::tsk {
    struct TSK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TSK>, arg1: 0x2::coin::Coin<TSK>) {
        0x2::coin::burn<TSK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TSK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TSK>>(0x2::coin::mint<TSK>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<TSK>) : u64 {
        0x2::coin::total_supply<TSK>(arg0)
    }

    fun init(arg0: TSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSK>(arg0, 9, b"TSK", b"Truth Seeker", b"The User Owned AI Truth Seeker Revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://truth.ai/tsk-logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: &mut 0x2::coin::TreasuryCap<TSK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TSK>>(0x2::coin::mint<TSK>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

