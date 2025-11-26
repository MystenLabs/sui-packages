module 0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::btcvc {
    struct BTCVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCVC>(arg0, 8, b"BTCvc", b"BTCvc", b"An vishwa token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vishwanetwork.xyz/logo/btcvc.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCVC>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::admin::transfer_admin_cap(0xd8fe9619ff2bcef53e0330b83b31ab380a04ee787dafecc19aac365a9824517f::admin::new_admin_cap(0x2::object::id<0x2::coin::TreasuryCap<BTCVC>>(&v2), arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCVC>>(v2, v3);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<BTCVC>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCVC>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

